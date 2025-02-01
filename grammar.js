module.exports = grammar({
  name: "jj_template",
  rules: {
    source: $ => repeat($._expression),

    _expression: $ => choice(
      $.method_call,
      $.unary_expression,
      $.binary_expression,
      $.function_call,
      $.literal,
      $.identifier,
      $.parenthesized_expression,
      $.lambda_expression,
    ),

    // Method calls
    method_call: $ => prec("call", seq(
      field("object", $._expression),
      ".",
      field("method", $.identifier),
      "(",
      field("arguments", optional($.argument_list)),
      ")",
    )),

    // Function calls
    function_call: $ => prec("call", seq(
      field("function", $.identifier),
      "(",
      field("arguments", optional($.argument_list)),
      ")",
    )),

    // Arguments
    argument_list: $ => seq(
      $._expression,
      repeat(seq(",", $._expression)),
      optional(","),
    ),

    // Unary operators
    unary_expression: $ => prec.right("unary", choice(
      seq("-", $._expression), // Negation
      seq("!", $._expression), // Logical not
    )),

    // Binary operators with precedence
    binary_expression: $ => choice(
      ...[
        ["++", "binary_concat"],   // Concatenation
        ["||", "binary_or"],       // Logical or
        ["&&", "binary_and"],      // Logical and
        ["==", "binary_compare"],  // Equality
        ["!=", "binary_compare"],  // Inequality
        [">=", "binary_compare"],  // Comparison
        [">",  "binary_compare"],
        ["<=", "binary_compare"],
        ["<",  "binary_compare"],
      ].map(([operator, precedence]) =>
        prec.left(precedence, seq(
          field("left", $._expression),
          field("operator", operator),
          field("right", $._expression),
        ))
      )
    ),

    // Literals
    literal: $ => choice(
      $.string_literal,
      $.number_literal,
      $.boolean_literal,
    ),

    // String literals with both single and double quote support
    string_literal: $ => choice(
      seq("\"", repeat(choice($.escape_sequence, /[^"\\]/)), "\""),
      seq("'", repeat(/[^']/), "'"),
    ),

    // Escape sequences for double-quoted strings
    escape_sequence: $ => token(choice(
      "\\\"",
      "\\\\",
      "\\t",
      "\\r",
      "\\n",
      "\\0",
      "\\e",
      /\\x[0-9a-fA-F]{2}/,
    )),

    // Number literals (integers)
    number_literal: $ => /-?\d+/,

    // Boolean literals
    boolean_literal: $ => choice("true", "false"),

    // Identifiers for variables, functions, and methods
    identifier: $ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    // Parenthesized expressions for grouping
    parenthesized_expression: $ => seq(
      "(",
      $._expression,
      ")",
    ),

    // Lambda expressions (for list operations like filter and map)
    lambda_expression: $ => prec.right("lambda", seq(
      "|",
      field("parameters", $.lambda_parameters),
      "|",
      field("body", $._expression),
    )),
    lambda_parameters: $ => seq(
      $.identifier,
      repeat(seq(",", $.identifier)),
      optional(","),
    ),

    // Comments
    comment: $ => token(seq("#", /.*/)),

    // Whitespace handling
    _whitespace: $ => /\s+/,
  },

  extras: $ => [
    $.comment,
    $._whitespace,
  ],

  precedences: $ => [
    [
      "call",
      "unary",
      "binary_compare",
      "binary_and",
      "binary_or",
      "binary_concat",
      "lambda",
    ]
  ],

  conflicts: $ => [
    [$._expression, $.function_call],
  ],

  // Define tokens that should be considered as keywords
  word: $ => $.identifier
});
