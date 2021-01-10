" Plug installer
call plug#begin()
" Navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'christoomey/vim-tmux-navigator'
Plug 'Yggdroot/indentLine' 
" Completion
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Language
Plug 'tpope/vim-surround'
Plug 'nvie/vim-flake8'
" Commands
Plug 'tpope/vim-commentary'
" Searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Git plugins
Plug 'airblade/vim-gitgutter'
" Folding
Plug 'pseewald/vim-anyfold'
" Python 
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'fisadev/vim-isort'
Plug 'tell-k/vim-autopep8'
Plug 'tenfyzhong/autoflake.vim', {'do': 'pip install autoflake'}
Plug 'Konfekt/FastFold'
" Testing
Plug 'janko/vim-test'
call plug#end()

" set mapleaderkey
let mapleader = "\<Space>"

" Copy & paste to system clipboard with leader + p/y
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Natural window spliting
set splitbelow
set splitright

"relative numbering
set relativenumber

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" resize current buffer by +/- 5 
nnoremap <C-W>h :vertical resize -5<cr>
nnoremap <C-W>j :resize +5<cr>
nnoremap <C-W>k :resize -5<cr>
nnoremap <C-W>l :vertical resize +5<cr>

" Update coping with large files
set synmaxcol=2048

" Set numbering
set nu
" Set numbering bold
highlight LineNr cterm=bold

" Manage backup and undo files
set backupdir=/tmp//
set directory=/tmp//
set undodir=/tmp//

"Search in selected text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

"PLUGIN CONFIGURATION
" -------------------

" Set nerdtree shortcut
map <A-1> :NERDTreeToggle<CR>

" Ale
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_linters = {'python': ['flake8']}

" FZF
" Open files list
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>O :Files!<CR>

" Recent files
nnoremap <silent> <leader>r :History<CR>

"start a search query by pressing \
nnoremap <silent> <leader>w  :Ag<cr>'

" GIT
"Set update time to faster
set updatetime=250
"
" GitGutter update
let g:gitgutter_realtime = 0
let g:gitgutter_eager = 0

" Disable show diff window
let g:autopep8_disable_show_diff=1

" COC
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" set statusline^=%{coc#status()}

" let g:coc_node_path = '/root/.nvm/versions/node/v15.5.0/bin/node;/usr/bin/node'
let g:coc_global_extensions = ["coc-python",
            \ "coc-json",
            \ "coc-ultisnips"]
            " \ "coc-eslint",
            " \ "coc-html",
            " \ "coc-prettier",
            " \ "coc-css",
            " \ "coc-tslint",
            " \ "coc-tsserver",
            " \ "coc-tailwindcss",
            " \ "coc-vetur"]


" UltiSnips
let g:UltiSnipsExpandTrigger="<TAB>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"

" Vim-snippets
let g:UltiSnipsSnippetDirectories=["~/.config/nvim/custom_snippets"]

" Markdown
let g:mkdp_browser = 'firefox'

" VIM-Test
let test#python#pytest#executable = 'python -m pytest'

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

let test#strategy = "neovim"
let g:test#python#pytest#options = {
    \ 'nearest': '-qql',
    \ 'file':    '-qq --tb=native',
    \ 'suite':   '-qq --tb=no',
  \}

" Isort
nnoremap <silent> <leader>i :Autoflake --remove-all-unused-import<cr> \| :Isort<cr>

" AUTOFORMAT
" Autopep8, Clang 
autocmd FileType python nnoremap <buffer> <leader>a  :Autopep8<cr>
autocmd FileType python vnoremap <buffer> <leader>a  :Autopep8<cr>
autocmd FileType c,cpp,objc nnoremap <buffer> <leader>a  :<C-u>ClangFormat<cr>
autocmd FileType c,cpp,objc vnoremap <buffer><leader>a :ClangFormat<CR>
"nnoremap <silent> <leader>a  :Autopep8<cr>

" Syntax C++
let g:lsp_cxx_hl_use_text_props = 1

" Folding
filetype plugin indent on
syntax on
set foldlevel=99
