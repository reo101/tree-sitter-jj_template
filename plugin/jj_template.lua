local ok, parsers = pcall(require, "nvim-treesitter.parsers")
if ok then
  local parser_configs = parsers.get_parser_configs()
  if not parser_configs.jj_template then
    parser_configs.jj_template = {
      install_info = {
        url = "https://github.com/reo101/tree-sitter-jj_template",
        files = { "src/parser.c" },
        branch = "master",
      },
      filetype = "jj_template",
    }
  end
end
