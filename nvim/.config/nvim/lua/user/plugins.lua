local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
    use "windwp/nvim-autopairs"  -- Autopairs, integrates with both cmp and treesitter
    use "numToStr/Comment.nvim"  -- Easily comment stuff
    use "kyazdani42/nvim-web-devicons"
    use "kyazdani42/nvim-tree.lua"
    use {
        'romgrk/barbar.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }
    use "moll/vim-bbye"
    use "nvim-lualine/lualine.nvim"
    use "akinsho/toggleterm.nvim"
    use "ahmedkhalf/project.nvim"
    use "lewis6991/impatient.nvim"
    use "lukas-reineke/indent-blankline.nvim"
    use "goolord/alpha-nvim"
    use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
    use "folke/which-key.nvim"

    -- Colorschemes
    use "edibotopic/nvim-base16"
    use ({ "typicode/bg.nvim" }) -- Adapt terminal background on colorscheme change

    -- cmp plugins
    use "hrsh7th/nvim-cmp"         -- The completion plugin
    use "hrsh7th/cmp-buffer"       -- buffer completions
    use "hrsh7th/cmp-path"         -- path completions
    use "hrsh7th/cmp-cmdline"      -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"
    use "kdheepak/cmp-latex-symbols"

    -- snippets
    use "L3MON4D3/LuaSnip"             --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP TODO: switch to Mason
    use "neovim/nvim-lspconfig"           -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer
    use "tamago324/nlsp-settings.nvim"    -- language server settings defined in json for
    use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters

    -- Zig
    -- use "ziglang/zig.vim"

    -- Rust
    -- use 'simrat39/rust-tools.nvim' TODO

    -- Java
    use { "mfussenegger/nvim-jdtls", ft = { "java" } }

    -- Telescope
    use "nvim-telescope/telescope.nvim"

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "JoosepAlviste/nvim-ts-context-commentstring"

    -- Git
    use "lewis6991/gitsigns.nvim"
    
    -- Interactive
    -- use { 'michaelb/sniprun', run = 'bash ./install.sh' }
    -- use 'tpope/vim-dispatch'
    -- use 'radenling/vim-dispatch-neovim'

    -- Misc plugins
    -- use "tidalcycles/vim-tidal"
    use "folke/zen-mode.nvim"
    use "folke/twilight.nvim"
    -- use "luizribeiro/vim-cooklang"
    use { 'ggandor/leap.nvim',
        config = function()
            require("leap").set_default_keymaps()
        end
    }
    use {
      'stevearc/oil.nvim',
    }
    -- use 'davidgranstrom/nvim-markdown-preview'
    use({
        "quarto-dev/quarto-vim",
        requires = {
            { "vim-pandoc/vim-pandoc-syntax" },
        },
        ft = { "quarto" },
    })
    use({
        "kaarmu/typst.vim",
        ft = { "typst" },
    })
    use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }
    use 'lepture/vim-jinja'
    -- use 'https://github.com/PolyCement/vim-tweego'
    -- use 'jbyuki/venn.nvim'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons"
    }

    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
