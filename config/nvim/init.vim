" don't bother with vi compatibility
set nocompatible

" Enable syntax highlighting
syntax enable

" Enable auto indentation
set autoindent

" Fix broken backspace in some setups
set backspace=indent,eol,start

" Reload files when changed on disk, i.e. via `git checkout`
set autoread

" See :help crontab
set backupcopy=yes

" Yank and paste with the system clipboard
set clipboard=unnamed

" Encoding
set encoding=utf-8

" Search
set ignorecase
set incsearch " Search as you type
set hls       " Highlight search
set smartcase " Case-sensitive search if any caps

" Always show statusline
set laststatus=2

" Show trailing whitespace
set list
set listchars=tab:•\ ,trail:▫

" Show line numbers
set number relativenumber

" Show where you are
set ruler

" Show context above/below cursorline
set scrolloff=3

" Show command in status bar
set showcmd

" set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
" " show a navigable menu for tab completion
" set wildmenu
" set wildmode=longest,list,full

" Enable spell-check
au FileType *tex,markdown,text,gitcommit setlocal spell spelllang=en_us,cjk

" When split, split to the bottom right
set splitbelow
set splitright

" Highlight current line
set cursorline
hi cursorline term=underline cterm=underline ctermbg=NONE gui=underline

" Tab & spaces
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" Set leader key
let mapleader = ','

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if !has('nvim') && exists('$TMUX')  " Support resizing in tmux
  set ttymouse=xterm2
endif

" Folding
" set nofoldenable
" set foldmethod=syntax

" nnoremap <leader>t :CtrlP<CR>
" nnoremap <leader>T :CtrlPClearCache<CR>:CtrlP<CR>
" nnoremap <leader>g :GitGutterToggle<CR>
" noremap <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" in case you forgot to sudo
cnoremap w!! %!sudo tee > /dev/null %


call plug#begin('~/.local/share/nvim/plugged')

" Color theme
Plug 'marko-cerovac/material.nvim'
let g:material_style = "palenight"
let g:material_terminal_italics = 1

" Status line
" if has('nvim')
    " Plug 'nvim-lualine/lualine.nvim'
" else
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled      = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tabs    = 1
let g:airline#extensions#branch#enabled       = 1
" Do not ignore `term://`
let g:airline#extensions#tabline#ignore_bujfadd_pat =
    \ '!|defx|gundo|nerd_tree|startify|tagbar|undotree|vimfiler'
let g:airline_theme = 'base16_material_palenight'
" endif

" Start screen
Plug 'mhinz/vim-startify'
let g:startify_session_persistence = 1
let g:startify_bookmarks = [
    \ {'c': '~/.config/nvim/init.vim'},
    \ {'f': '~/.config/fish/config.fish'},
    \ ]

" Note taking
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{
    \ 'path': '~/notes/',
    \ 'syntax': 'markdown',
    \ 'ext': '.md',
    \ }]

" Writing
Plug 'junegunn/goyo.vim'
nnoremap <leader>g :Goyo<CR>
au BufReadPost,BufNewFile *    :Goyo!
au BufReadPost,BufNewFile *.md :Goyo
Plug 'junegunn/limelight.vim'
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" Go to specific line&col
Plug 'wsdjeg/vim-fetch'

" Git
Plug 'airblade/vim-gitgutter'
" let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0
Plug 'tpope/vim-fugitive'

" Tmux
Plug 'christoomey/vim-tmux-navigator'

" Plug 'ctrlpvim/ctrlp.vim'
" Plug 'rking/ag.vim'

Plug 'majutsushi/tagbar'
let g:tagbar_left=1
nnoremap <leader>t :TagbarToggle<CR>

" " Snipmate
" Plug 'garbas/vim-snipmate'
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" " use the new SnipMate parser
" let g:snipMate = { 'snippet_version' : 1 }

" Nerdtree
if has('nvim')
    Plug 'nvim-tree/nvim-web-devicons'
    Plug 'nvim-tree/nvim-tree.lua'
else
    Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
    let g:NERDSpaceDelims=1
    Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': 'NERDTreeToggle' }
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
endif

" Commentary
Plug 'scrooloose/nerdcommenter'
nnoremap <leader><space> :call nerdcommenter#Comment(0, "toggle")<CR>
vnoremap <leader><space> :call nerdcommenter#Comment(0, "toggle")<CR>gv
let g:NERDSpaceDelims            = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines    = 1
let g:NERDCreateDefaultMappings  = 0 " No default key mapping
let g:NERDCustomDelimiters = { 'asm': { 'left': '//' } }

" Auto closing
Plug 'jiangmiao/auto-pairs'
au FileType rust     let b:AutoPairs = AutoPairsDefine({'::\zs<': '>'})
let g:AutoPairsShortcutFastWrap = '<C-f>'

" <M-p> : Toggle Autopairs
" <M-b> : BackInsert

" Quick alignment
Plug 'junegunn/vim-easy-align'
xmap <leader>a <Plug>(EasyAlign)
nmap <leader>a <Plug>(EasyAlign)

" Auto format
Plug 'rhysd/vim-clang-format', { 'for': ['c', 'cpp'] }
let g:clang_format#code_style = 'google'
let g:clang_format#style_options = {
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "AccessModifierOffset" : -4,
            \ "Standard" : "C++17",
            \ "BreakBeforeBraces" : "Linux",
            \ "AlwaysBreakAfterDefinitionReturnType" : "false",
            \ "ColumnLimit" : 80,
            \ "IndentCaseLabels": "false",
            \ }

" Generate some dummy text
Plug 'vim-scripts/loremipsum'

" Replace text
Plug 'vim-scripts/greplace.vim'

" Code highlighting
if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
endif

" Org Mode
if has('nvim')
    Plug 'nvim-orgmode/orgmode'
endif

" LSP support
if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    " Snippets
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    " Plug 'hrsh7th/vim-vsnip-integ'
else
    Plug 'dense-analysis/ale'
    let g:ale_set_balloons = 1
    let g:ale_set_loclist = 0   " Wired settings
    " let g:airline#extensions#ale#enabled = 1
    let g:ale_completion_enabled = 1
    " let g:ale_floating_preview = 1
    " let g:ale_hover_to_preview = 1
    " let g:ale_keep_list_window_open = 1
endif

func! Cj()
    if len(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')) != 0
        " https://www.reddit.com/r/vim/comments/5ulthc/how_would_i_detect_whether_quickfix_window_is_open/
        " filter(range(1, winnr('$')), 'getwinvar(v:val, "&ft") == "qf"')
        " Also, do a wrapping
        " https://github.com/romainl/vim-qf/blob/master/autoload/qf/wrap.vim<Paste>
        try
            cnext
        catch /^Vim\%((\a\+)\)\=:E553/
            cfirst
        catch /^Vim\%((\a\+)\)\=:E\%(325\|776\|42\):/
        endtry
        " Also, remember there are `:cnf` and `:cpf` to jump to first of files.
    elseif &diff
        norm! ]c
    elseif &spell
        norm! ]s
        " Also, remember there are `z=`, `zg` and `zug` commands
    else
        " https://stackoverflow.com/a/18547013
        " It's essential to use the (remapping) :normal
        lua vim.diagnostic.goto_next({float = {border = "single"}})
    endif
endfunction

func! Ck()
    if len(filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')) != 0
        try
            cprevious
        catch /^Vim\%((\a\+)\)\=:E553/
            clast
        catch /^Vim\%((\a\+)\)\=:E\%(325\|776\|42\):/
        endtry
    elseif &diff
        norm! [c
    elseif &spell
        norm! [s
    else
        lua vim.diagnostic.goto_prev({float = {border = "single"}})
    endif
endfunction

nmap <silent> <leader>j :call Cj()<CR>
nmap <silent> <leader>k :call Ck()<CR>

" Change root to git working dir, excluding (default) Makefile
Plug 'airblade/vim-rooter'
let g:rooter_patterns = ['.git', '_darcs', '.hg', '.bzr', '.svn']

" Fuzzy finder
" Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Making sure to have latest binary
Plug 'junegunn/fzf.vim'
Plug 'ojroques/nvim-lspfuzzy'
let g:fzf_colors = { 'border': ['fg', 'Label'] }
let g:fzf_tags_command = 'ctags -R --languages=c,c++'

" Files
map <leader>p    :Files<CR>
" map <C-p>        :GFiles<CR>
nmap <leader>bb  :Buffers<CR>
" Workaround to have this trailing space in command
nmap <leader>f   :Rg  <BS>
xmap <leader>f   y:Rg <C-R>=escape(@",'/\')<CR>
nmap <leader>m   :Marks<CR>
" nmap <leader>r   :Tags<CR>
" nmap <leader>kr  :BTags<CR>

call plug#end()


" Color theme
set background=dark
colorscheme material

" set completeopt=menuone,noinsert,noselect
set completeopt=menu,menuone,noselect

" LSP settings
if has('nvim')

hi link LspDiagnosticsDefaultError    Error
hi link LspDiagnosticsDefaultWarning  Question

lua << EOF

    -- Setup nvim-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true
    -- empty setup using defaults
    require("nvim-tree").setup()

    function formatText()
        -- local _, ls, _ , _ = unpack(vim.fn.getpos("'<"))
        -- local _, le, _ , _ = unpack(vim.fn.getpos("'>"))
        -- local a = vim.api.nvim_buf_get_lines(0, ls-1, le, false)
        -- print(vim.inspect(a))
        print("todo!")
    end
    vim.keymap.set('x', '<leader>wf', formatText, {})

    -- Setup lspfuzzy
    local nvim_lsp = require('lspconfig')
    require('lspfuzzy').setup {
        methods = 'all',               -- either 'all' or a list of LSP methods (see below)
        jump_one = true,               -- jump immediately if there is only one location
        save_last = false,             -- save last location results for the :LspFuzzyLast command
        callback = nil,                -- callback called after jumping to a location
        fzf_preview = {                -- arguments to the FZF '--preview-window' option
            'right:+{2}-/2'            -- preview on the right and centered on entry
        },
        fzf_action = {                 -- FZF actions
            ['ctrl-t'] = 'tab split',  -- go to location in a new tab
            ['ctrl-v'] = 'vsplit',     -- go to location in a vertical split
            ['ctrl-x'] = 'split',      -- go to location in a horizontal split
        },
        fzf_modifier = ':~:.',         -- format FZF entries, see |filename-modifiers|
        fzf_trim = true,               -- trim FZF entries
    }

    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- local opts = { noremap=true, silent=true, popup_opts = { border = "single" } }
    local opts = { noremap=true, silent=true }
    -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    -- vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next({float = {border = border}})<CR>', {})
    -- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>', {})
    vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the followingnkeys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Show border
        vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
        vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        -- vim.keymap.set('n', '<leader>wl', function()
        --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        -- end, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        -- vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)
    end

    -- Signs
    local signs = { Error = "✖ ", Warning = "⚠ ", Hint = "i ", Information = "i " }
    for type, icon in pairs(signs) do
        local hl = "LspDiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    -- Setup nvim-cmp
    local cmp = require('cmp')
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        }, {
            { name = 'buffer' },
        }, {
            { name = 'orgmode' },
        })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

    -- Setup lspconfig.
    local capabilities = require('cmp_nvim_lsp')
        .default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = {
        'clangd',
        'rust_analyzer',
        'hls',
        'gopls',
        'pyright',
        'tsserver',
        'elmls',
    }
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end

    -- Load custom treesitter grammar for org filetype
    require('orgmode').setup_ts_grammar()

    -- Setup tree-sitter
    require('nvim-treesitter.configs').setup {
        ensure_installed = {
            "bash",
            "fish",
            "c",
            "cpp",
            "rust",
            "haskell",
            "go",
            "python",
            "typescript",
            "vim",
            "vimdoc",
            "query",
            "cmake",
            "make",
            "toml",
            "nix",
            "latex",
            "markdown",
            "markdown_inline",
            "comment",
            "org",
            "html",
        },
        sync_install = false,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "org" },
        },
    }
    require('nvim-treesitter.install').compilers = { "gcc-11" }

    require('orgmode').setup({
        org_agenda_files = { '~/orgs/*' },
        org_default_notes_file = '~/orgs/default.org',
    })

EOF

endif

" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" Keyboard shortcuts
" Moving around
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Command select
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>

" Functions
if has("nvim")
    nnoremap <leader>d :NvimTreeToggle<CR>
else
    nnoremap <leader>d :NERDTreeToggle<CR>
end
" nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>s :noh <bar> call StripTrailing() <CR>
" nnoremap <leader>a :Ag<space>

" Tabs
" Doesn't seem to recieve <C-Tab> :(
nnoremap <S-tab>  :tabprevious<CR>
nnoremap <C-q>    :tabnext<CR>
nnoremap <C-t>    :tabnew<CR>
inoremap <S-tab>  <Esc>:tabprevious<CR>i
inoremap <C-q>    <Esc>:tabnext<CR>i
inoremap <C-t>    <Esc>:tabnew<CR>

" Buffers
nnoremap <leader>bt :enew<CR>
nnoremap <leader>l  :bnext<CR>
nnoremap <leader>h  :bprevious<CR>
nnoremap <leader>bq :bp <BAR> bd #<CR>
nnoremap <leader>bl :ls<CR>
nnoremap <leader>bc :call CloseBuf()<CR>
" nnoremap <A-q>          :bprevious<CR>
" nnoremap <A-tab>        :bnext<CR>
" nnoremap <silent> <A-w> :call CloseBuf()<CR>
" " Work around w mac keybindings
" nnoremap œ              :bprevious<CR>
" nnoremap <silent> ∑     :call CloseBuf()<CR>

" Terminal
tnoremap <Esc> <C-\><C-n>
" tnoremap <M-q>   <C-\><C-n>:bprevious<CR>
" tnoremap <M-Tab> <C-\><C-n>:bnext<CR>

" Others
" inoremap jj <ESC>
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> :w<CR>
" Don't copy the contents of an overwritten selection.
vnoremap p "_dP
" End keyboard shortcuts

" Zoom & restore window
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>z :ZoomToggle<CR>

" Close buffer
func! CloseBuf()
    if len(getbufinfo({'buflisted':1})) == 1
        bdelete
    else
        bprevious
        bdelete #
    endif
endfunction

" Strip whitespaces
function! StripTrailing()
  let previous_search=@/
  let previous_cursor_line=line('.')
  let previous_cursor_column=col('.')
  %s/\s\+$//e
  let @/=previous_search
  call cursor(previous_cursor_line, previous_cursor_column)
endfunction

" Insert header guard for C/C++ header files
function! s:insert_gates()
    let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
    execute "normal! i#ifndef __" . gatename . "__"
    execute "normal! o#define __" . gatename . "__"
    execute "normal! 3o"
    execute "normal! Go#endif /* __" . gatename . "__ */"
    normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

" nnoremap <leader>w :call ToggleWrapping()<CR>
" function! ToggleWrapping()
"   if &fo =~ 'a'
"     set fo-=a
"     echo "Text Wrapping Off"
"   else
"     set fo+=a
"     echo "Text Wrapping On"
"   endif
" endfunction


" Toggle background
" function! ToggleBG()
  " let s:tbg = &background
  " " Inversion
  " if s:tbg == "dark"
      " set background=light
      " let g:material_style = "deep ocean"
  " else
      " set background=dark
      " let g:material_style = "palenight"
  " endif
" endfunction
" noremap <leader>bg :call ToggleBG()<CR>


" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" fdoc is yaml
autocmd BufRead,BufNewFile *.fdoc set filetype=yaml
" md is markdown
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.md set spell
" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Fix Cursor in TMUX
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Don't highlight current line
set nocursorline

" Jump to the last position when reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" Fix cursor type in Kitty
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Fix color scheme
" highlight clear Pmenu
" highlight Pmenu term=reverse ctermbg=255 guisp=LightMagenta
" highlight Pmenu ctermbg=255 guisp=LightMagenta

" Vim snip config
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
" jump prev may cause vim hung :(
" imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
" smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
