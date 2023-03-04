if vim.g.neovide == true then
    -- TODO: Fonts

    -- Keybinds
    vim.api.nvim_set_keymap("n", "<C-+>", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>",
        { silent = true })
    vim.api.nvim_set_keymap("n", "<C-->", ":lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>",
        { silent = true })
    vim.api.nvim_set_keymap("n", "<C-0>", ":lua vim.g.neovide_scale_factor = 1<CR>", { silent = true })

    -- Blur
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

    -- Transparency
    -- vim.g.neovide_transparency = 0.9

    -- Fullscreen
    -- vim.g.neovide_fullscreen = false

    -- Animations
    vim.g.neovide_cursor_animation_length = 0.11
    vim.g.neovide_cursor_trail_size = 0.4
end
