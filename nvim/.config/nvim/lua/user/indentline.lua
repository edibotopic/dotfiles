local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
	return
end

ibl.setup({
  indent = {
    tab_char = "▎",
    highlight = "IndentBlanklineChar",
  },
  --whitespace = {
  --  highlight = "IndentBlanklineSpaceChar",
  --},
  scope = {
    char = "▎",
    show_start = true,
    show_end = false,
    injected_languages = true,
    highlight = "IndentBlanklineContextChar",
    include = {
      node_type = {
        ["*"] = {
            "class",
            "return",
            "function",
            "method",
            "^if",
            "^while",
            "jsx_element",
            "^for",
            "^object",
            "^table",
            "block",
            "arguments",
            "if_statement",
            "else_clause",
            "jsx_element",
            "jsx_self_closing_element",
            "try_statement",
            "catch_clause",
            "import_statement",
            "operation_type",
        },
      },
    },
  },
  exclude = {
        filetypes = {
            "help",
            "startify",
            "dashboard",
            "packer",
            "neogitstatus",
            "NvimTree",
            "Trouble",
        }
  },
})
