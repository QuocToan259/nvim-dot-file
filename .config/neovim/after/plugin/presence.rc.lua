local status, presence = pcall(require, 'presence')
if (not status) then return end

presence.setup {
        auto_update = true,
        neovim_image_text = "Neovim",
        main_image = "file",
        client_id = "793271441293967371",
        log_level = nil,
        file_assets = {
                js = { "Javascript", "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNCTzPO12FHETdFvWKKYuxBGO8YgBFY6oMlQ&s" }
        },
        show_time = true,
        buttons = true,

        editing_text = "📝 Editing %s",
        file_explorer_text = "Browsing %s",
        reading_text = "Reading %s",
        workspace_text = "Working on %s",
        git_commit_text = "Commiting changes"
}
