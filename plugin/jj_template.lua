local ok, parsers = pcall(require, "nvim-treesitter.parsers")
if ok then
  if not parsers.jj_template then
    parsers.jj_template = {
      install_info = {
        url = "https://github.com/reo101/tree-sitter-jj_template",
        files = { "src/parser.c" },
        branch = "master",
      },
      filetype = "jj_template",
    }
  end
end
