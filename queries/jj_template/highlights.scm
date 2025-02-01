;; Function calls and methods
(function_call
  function: (identifier) @function)

(method_call
  method: (identifier) @method)

;; Variables and parameters
(identifier) @variable

(lambda_expression
  parameters: (lambda_parameters
    (identifier) @parameter))

;; Literals
(string_literal) @string
(escape_sequence) @string.escape
(number_literal) @number
(boolean_literal) @boolean

;; Comments
(comment) @comment

;; Operators
[
  ; "+"
  "-"
  "=="
  "!="
  ">"
  ">="
  "<"
  "<="
  "&&"
  "" "" ""
  "++"
  "!"
] @operator

;; Delimiters
[
  "("
  ")"
  ","
] @punctuation.delimiter

"." @punctuation.delimiter
"" "" @punctuation.special

;; Constants
((identifier) @constant.builtin
  (#eq? @constant.builtin "self"))

;; Built-in keywords
((identifier) @keyword
  (#any-of? @keyword "true" "false"))

;; Built-in functions
((function_call
  function: (identifier) @function.builtin)
  (#any-of? @function.builtin "fill" "indent" "pad_start" "pad_end" "truncate_start" "truncate_end" "label" "raw_escape_sequence" "if" "coalesce" "concat" "separate" "surround" "config"))

;; Common methods from core types
((method_call
  method: (identifier) @method.builtin)
  (#any-of? @method.builtin "description" "change_id" "commit_id" "parents" "author" "committer" "signature" "mine" "working_copies" "current_working_copy" "bookmarks" "local_bookmarks" "remote_bookmarks" "tags" "git_refs" "git_head" "divergent" "hidden" "immutable" "contained_in" "conflict" "empty" "diff" "root"))

;; String methods
((method_call
  method: (identifier) @method.builtin)
  (#any-of? @method.builtin "len" "contains" "first_line" "lines" "upper" "lower" "starts_with" "ends_with" "remove_prefix" "remove_suffix" "substr"))

;; List methods
((method_call
  method: (identifier) @method.builtin)
  (#any-of? @method.builtin "len" "join" "filter" "map"))

;; Timestamp methods
((method_call
  method: (identifier) @method.builtin)
  (#any-of? @method.builtin "ago" "format" "utc" "local" "after" "before"))

;; Path and other utility methods
((method_call
  method: (identifier) @method.builtin)
  (#any-of? @method.builtin "display" "parent" "normal_hex" "short" "shortest" "status" "key" "local" "domain" "normal_target" "removed_targets" "added_targets" "tracked" "tracking_present" "color_words" "git" "stat" "summary"))
