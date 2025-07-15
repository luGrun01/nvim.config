set encoding=utf-8
set rtp+=~/.fzf

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'chrisbra/csv.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'camspiers/animate.vim'
" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'mhinz/vim-signify'
Plug 'pbrisbin/vim-mkdir'
" git
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

Plug 'vim-scripts/tComment'
Plug 'yuttie/comfortable-motion.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
" Plug 'prabirshrestha/vim-lsp'
Plug 'neovim/nvim-lspconfig'
" Plug 'lighttiger2505/deoplete-vim-lsp'
Plug 'ervandew/supertab'
Plug 'Shougo/context_filetype.vim' " Completion from other opened files
Plug 'preservim/tagbar'
Plug 'chentoast/marks.nvim'
Plug '0xstepit/flow.nvim'
Plug 'stevearc/dressing.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

Plug 'andymass/vim-matchup'
Plug 'ahmedkhalf/project.nvim'

" Python
Plug 'tell-k/vim-autopep8'
Plug 'mfussenegger/nvim-lint'
Plug 'Vimjas/vim-python-pep8-indent'

" Rust
" Plug 'mrcjkb/rustaceanvim'
"
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
call plug#end()

let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = '/Users/luana.grunheidt/.pyenv/versions/3.10.14/bin/python'
let g:python_host_prog = '/Users/luana.grunheidt/.pyenv/versions/3.10.14/bin/python'
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:loaded_matchit = 1

" ================ General Config ====================

set autoindent
set autoread
set backspace=indent,eol,start
set clipboard+=unnamedplus
set cmdheight=2
set completeopt=menuone,noinsert,noselect
set diffopt+=vertical
set expandtab
set fillchars+=vert:│
set foldnestmax=5
set gdefault
set hidden
set history=10000
set hlsearch
set inccommand=split
set incsearch
set laststatus=2
set linebreak
set list listchars=tab:»·,trail:·,nbsp:·
set mouse=a
set nobackup
set nofoldenable
set noswapfile
set nowb
set nowritebackup
set number relativenumber
set ruler
set scrolloff=100
set shiftwidth=2
set shortmess+=c
set showcmd
set sidescroll=1
set sidescrolloff=15
set signcolumn=yes
set smartindent
set smarttab
set softtabstop=2
set t_Co=256
set tabstop=2
set termguicolors
set timeout timeoutlen=1500
set undodir=~/.config/nvim/.backups
set undofile
set updatetime=300
set background=dark
filetype indent on
filetype plugin on
syntax on

if !has('gui_running')
  set t_Co=256
endif
highlight Cursor guifg=magenta guibg=white
highlight iCursor guifg=green guibg=white
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver100-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
colorscheme catppuccin

" =========== generic remaps
" Leader key is <space>
let mapleader=" "
" For repeating macros
nnoremap , @@
"<leader-l> redraws the screen and removes any search highlight
nnoremap <silent> <leader>l :nohl<CR><C-l>

" ========== git remaps
" git diff
if &diff
  map <leader>1 :diffget LOCAL<CR>
  map <leader>2 :diffget BASE<CR>
  map <leader>3 :diffget REMOTE<CR>
endif

"Vim fugitive
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gbl :Git blame<CR>
nnoremap <leader>gc :Git commit -v -q<CR>
nnoremap <space>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gps :Git push origin HEAD<CR>
nnoremap <leader>gpl :Git pull origin HEAD<CR>
nnoremap <leader>gbr :GBranch<CR>
nnoremap <leader>gn :Merginal<CR>

" =========== generic autocmds
" Automatically deletes all trailing whitespace on save.
au BufWritePre * %s/\s\+$//e
" Always start in same position when opening file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif "
au CursorHold * lua vim.diagnostic.open_float()


let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
