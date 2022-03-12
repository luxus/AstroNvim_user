return {
  polish = function()
    local opts = { noremap = true, silent = true }
    local set = vim.opt

    local map = function(mode, shortcut, command)
      vim.api.nvim_set_keymap(mode, shortcut, command, opts)
    end
    local _map = function(shortcut, command)
      vim.api.nvim_set_keymap("", shortcut, command, {})
    end
    local nmap = function(shortcut, command)
      map("n", shortcut, command)
    end
    local vmap = function(shortcut, command)
      map("v", shortcut, command)
    end
    local imap = function(shortcut, command)
      map("i", shortcut, command)
    end
    local xmap = function(shortcut, command)
      map("x", shortcut, command)
    end
    local tmap = function(shortcut, command)
      map("t", shortcut, command)
    end

    local unmap = function(mode, shortcut)
      vim.api.nvim_del_keymap(mode, shortcut)
    end
    local nunmap = function(shortcut)
      unmap("n", shortcut)
    end
    local vunmap = function(shortcut)
      unmap("v", shortcut)
    end

    -- Set options

    -- set colorscheme without autocmd
    vim.cmd [[
      autocmd! colorscheme
      colorscheme catppuccin
    ]]

    -- show whitespace characters
    set.list = true
    set.listchars = {
      tab = "│→",
      extends = "⟩",
      precedes = "⟨",
      trail = "·",
      nbsp = "␣",
    }
    set.showbreak = "↪ "
    -- soft wrap lines
    set.wrap = true
    -- linebreak soft wrap at words
    set.linebreak = true
    -- set spell and thesaurus files
    set.spellfile = "~/.config/nvim/lua/user/spell/en.utf-8.add"
    set.thesaurus = "~/.config/nvim/lua/user/spell/mthesaur.txt"

    -- Set maps

    -- Disable some default mappings
    nunmap "<C-Up>"
    nunmap "<C-Down>"
    nunmap "<C-Left>"
    nunmap "<C-Right>"
    nunmap "<A-j>"
    nunmap "<A-k>"
    nunmap "ca"
    nunmap "rn"
    nunmap "<C-w>"
    nunmap "<C-q>"
    nunmap "<C-\\>"
    nunmap "<leader>d"
    nunmap "<leader>db"
    nunmap "<leader>fw"
    nunmap "<leader>ff"
    nunmap "<leader>fb"
    nunmap "<leader>fh"
    nunmap "<leader>fo"
    nunmap "<leader>h"
    nunmap "<leader>s"
    nunmap "<leader>sb"
    nunmap "<leader>sh"
    nunmap "<leader>sm"
    nunmap "<leader>sr"
    nunmap "<leader>sk"
    nunmap "<leader>sc"
    vunmap "<A-j>"
    vunmap "<A-k>"
    vunmap "p"
    vunmap "<"
    vunmap ">"
    vunmap "J"
    vunmap "K"

    -- disable default terminal mappings
    vim.cmd [[
      autocmd! TermMappings
    ]]

    -- resize with arrows
    nmap("<Up>", "<cmd>resize -2<CR>")
    nmap("<Down>", "<cmd>resize +2<CR>")
    nmap("<Left>", "<cmd>vertical resize -2<CR>")
    nmap("<Right>", "<cmd>vertical resize +2<CR>")
    -- navigating wrapped lines
    nmap("j", "gj")
    nmap("k", "gk")
    vmap("j", "gj")
    vmap("k", "gk")
    -- easy splits
    nmap("\\", "<cmd>split<cr>")
    nmap("|", "<cmd>vsplit<cr>")
    -- better increment/decrement
    nmap("-", "<c-x>")
    nmap("+", "<c-a>")
    nmap("-", "<c-x>")
    xmap("+", "g<c-a>")
    xmap("-", "g<c-x>")
    -- type template string
    imap(";mk", "<++>")
    imap("<S-Tab>", "<C-V><Tab>")
    -- terminal mappings
    tmap("<leader><esc>", "<c-\\><c-n>")
    tmap("<esc><esc>", "<c-\\><c-n>:q<cr>")
    tmap("<c-h>", "<c-\\><c-n><c-w>h")
    tmap("<c-j>", "<c-\\><c-n><c-w>j")
    tmap("<c-k>", "<c-\\><c-n><c-w>k")
    tmap("<c-l>", "<c-\\><c-n><c-w>l")

    _map("<c-e><c-e>", "<Plug>SendLine")
    _map("<c-e>", "<Plug>Send")

    -- date/time abbreviations
    vim.cmd [[
      inoreabbrev ndate <C-r>=strftime("%Y-%m-%d")<CR>
      inoreabbrev xdate <C-r>=strftime("%m/%d/%y")<CR>
      inoreabbrev fdate <C-r>=strftime("%B %d, %Y")<CR>
      inoreabbrev xtime <C-r>=strftime("%H:%M")<CR>
      inoreabbrev ftime <C-r>=strftime("%H:%M:%S")<CR>
      inoreabbrev dts   <C-r>=strftime("%Y/%m/%d %H:%M:%S -")<CR>
    ]]

    -- Autocompiler
    vim.cmd [[
      augroup autocomp
        autocmd VimLeave * !autocomp %:p stop
      augroup END
    ]]

    -- Mutt Emails
    vim.cmd [[
      augroup mutt
        autocmd BufNewFile,BufFilePre,BufRead /tmp/neomutt* set filetype=markdown
      augroup END
    ]]

    vim.cmd [[
      augroup rmd
        autocmd BufNewFile,BufFilePre,BufRead *.rmd set filetype=markdown
      augroup END
    ]]

    vim.cmd [[
      autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>
    ]]

    vim.cmd [[
      autocmd VimEnter,ColorScheme * lua require("user.theme").telescope_theme()
    ]]
  end,
}
