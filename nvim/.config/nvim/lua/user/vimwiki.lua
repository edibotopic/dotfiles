vim.g.vimwiki_list = {
    { path = '~/Dropbox/Notes_vault/', syntax = 'markdown', ext = '.wiki' },
}
vim.g.vimwiki_ext2syntax = { ['.wiki'] = 'media' }
-- vim.g.vimwiki_ext2syntax = { md= 'markdown',
--     mkd= 'markdown',
--     wiki = 'media'
--   }
vim.g.vimwiki_folding = ''
vim.g.vimwiki_listsyms = ' ○◐●✓'
-- vim.g.vimwiki_global_ext = 0 BUG: not working?
