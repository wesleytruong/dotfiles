return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      local parsers = {
        "bash",
        "c",
        "comment",
        "cpp",
        "css",
        "cuda",
        "go",
        "graphql",
        "html",
        "http",
        "javascript",
        "json",
        "latex",
        "lua",
        "python",
        "rust",
        "typescript",
      }
      local wanted = {}
      for _, lang in ipairs(parsers) do
        wanted[lang] = true
      end
      local installed = {}
      for _, lang in ipairs(ts.get_installed()) do
        installed[lang] = true
      end
      local missing = vim.tbl_filter(function(lang)
        return not installed[lang]
      end, parsers)
      if #missing > 0 then
        ts.install(missing)
      end
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("fruitninjaking-treesitter", { clear = true }),
        callback = function(ev)
          local ft = vim.bo[ev.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end
          if vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
            return
          end
          if wanted[lang] then
            ts.install({ lang })
          end
        end,
      })
      local query_linter_ns = vim.api.nvim_create_namespace("nvim.treesitter.query_linter")
      vim.diagnostic.config({ virtual_text = true }, query_linter_ns)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("fruitninjaking-ts-query", { clear = true }),
        pattern = "query",
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.treesitter.query.omnifunc"
          vim.api.nvim_create_autocmd({ "BufWritePost", "CursorHold" }, {
            buffer = ev.buf,
            callback = function()
              vim.treesitter.query.lint(ev.buf)
            end,
          })
          vim.treesitter.query.lint(ev.buf)
        end,
      })
      vim.keymap.set("n", "<F2>", "<cmd>Inspect<CR>", {
        desc = "Show Treesitter captures under cursor",
      })
    end,
  },
  --   "nvim-treesitter/nvim-treesitter",
  --   lazy = false,
  --   branch = "main",
  --   opts = {
  --     -- A list of parser names, or "all" (the four listed parsers should always be installed)
  --     ensure_installed = {
  --       "bash",
  --       "c",
  --       "comment",
  --       "css",
  --       "go",
  --       "graphql",
  --       "html",
  --       "http",
  --       "javascript",
  --       "json",
  --       "latex",
  --       "lua",
  --       -- "python",
  --       "rust",
  --       "typescript",
  --     },
  --
  --     -- Install parsers synchronously (only applied to `ensure_installed`)
  --     sync_install = false,
  --
  --     auto_install = true,
  --
  --     highlight = {
  --       -- `false` will disable the whole extension
  --       enable = true,
  --
  --       -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
  --       -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
  --       -- Using this option may slow down your editor, and you may see some duplicate highlights.
  --       -- Instead of true it can also be a list of languages
  --       additional_vim_regex_highlighting = false,
  --     },
  --     playground = {
  --       enable = true,
  --       disable = {},
  --       updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
  --       persist_queries = false, -- Whether the query persists across vim sessions
  --       keybindings = {
  --         toggle_query_editor = "o",
  --         toggle_hl_groups = "i",
  --         toggle_injected_languages = "t",
  --         toggle_anonymous_nodes = "a",
  --         toggle_language_display = "I",
  --         focus_language = "f",
  --         unfocus_language = "F",
  --         update = "R",
  --         goto_node = "<cr>",
  --         show_help = "?",
  --       },
  --     },
  --     query_linter = {
  --       enable = true,
  --       use_virtual_text = true,
  --       lint_events = { "BufWrite", "CursorHold" },
  --     },
  --   },
  --   build = ":TSUpdate",
  --   config = function(_, opts)
  --     require("nvim-treesitter.configs").setup(opts)
  --   end,
  --   dependencies = {
  --     {
  --       "nvim-treesitter/playground",
  --       cmd = {
  --         "TSPlaygroundToggle",
  --         "TSHighlightCapturesUnderCursor",
  --       },
  --       keys = {
  --         { "<F2>", "<cmd>TSHighlightCapturesUnderCursor<cr>", desc = "Show highlight group under cursor" },
  --       },
  --     },
  --   },
  -- },
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      max_lines = 1,
    },
  }
}
