if vim.g.neovide == true then
    -- TODO: Fonts

    -- Scaling
    vim.g.neovide_scale_factor = 0.6
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function()
        change_scale_factor(1.25)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.25)
    end)

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
