vim.opt_local.conceallevel = 2

vim.opt.wrap = true
-- enable indentation
vim.opt.breakindent = true
-- indent by an additional 2 characters on wrapped lines, when line >= 40 characters, put 'showbreak' at start of line
vim.opt.breakindentopt = "shift:2,min:40,sbr"
vim.opt.showbreak = ">>"
