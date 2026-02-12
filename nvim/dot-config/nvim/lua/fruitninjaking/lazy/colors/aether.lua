local function get_file_mtime(path)
    local stat = vim.uv.fs_stat(path)
    if not stat or not stat.mtime then
        return nil
    end

    if type(stat.mtime) == "table" then
        return stat.mtime.sec
    end

    return stat.mtime
end

local function get_omarchy_aether_opts(path)
    local ok, spec = pcall(dofile, path)
    if not ok or type(spec) ~= "table" then
        return {}
    end

    for _, plugin in ipairs(spec) do
        if type(plugin) == "table" and (plugin[1] == "bjarneo/aether.nvim" or plugin.name == "aether") then
            return type(plugin.opts) == "table" and plugin.opts or {}
        end
    end

    return {}
end

return {
    "bjarneo/aether.nvim",
    name = "aether",
    priority = 1000,
    opts = {
        colors = {},
    },
    config = function(_, opts)
        local omarchy_theme_path = vim.fn.expand("~/.config/omarchy/current/theme/neovim.lua")
        local sync_group = vim.api.nvim_create_augroup("AetherOmarchySync", { clear = true })
        local syncing = false
        local last_mtime = get_file_mtime(omarchy_theme_path)

        local function apply_aether()
            local merged_opts = vim.tbl_deep_extend("force", opts or {}, get_omarchy_aether_opts(omarchy_theme_path))
            require("aether").setup(merged_opts)
            vim.cmd.colorscheme("aether")
            last_mtime = get_file_mtime(omarchy_theme_path) or last_mtime
        end

        local function apply_if_active()
            if syncing or vim.g.colors_name ~= "aether" then
                return
            end

            syncing = true
            local ok, err = pcall(apply_aether)
            syncing = false

            if not ok then
                vim.notify("Aether sync failed: " .. err, vim.log.levels.WARN)
            end
        end

        syncing = true
        local ok, err = pcall(apply_aether)
        syncing = false
        if not ok then
            vim.notify("Aether setup failed: " .. err, vim.log.levels.ERROR)
            return
        end

        vim.api.nvim_create_autocmd("ColorScheme", {
            group = sync_group,
            pattern = "aether",
            callback = apply_if_active,
            desc = "Reapply Omarchy settings when switching to aether",
        })

        vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained" }, {
            group = sync_group,
            callback = function()
                if syncing or vim.g.colors_name ~= "aether" then
                    return
                end

                local mtime = get_file_mtime(omarchy_theme_path)
                if mtime and mtime ~= last_mtime then
                    apply_if_active()
                end
            end,
            desc = "Sync aether when Omarchy theme file changes",
        })
    end,
}
