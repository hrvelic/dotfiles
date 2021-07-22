set nocompatible " relax file compatibility restrictions
set encoding=utf-8 " use Unicode
set expandtab tabstop=2 shiftwidth=2 softtabstop=2 " Tab key enters 2 spaces. To enter a TAB character when `expandtab` is in effect, CTRL-v-TAB
set autoindent " Indent new line the same as the preceding line
set visualbell " errors flash screen rather than emit beep
set nowrap " disable line wrapping
set noshowmode " disable show mode since using lightline
set number " show line numbers
set relativenumber " show distances to current line
set showmatch " highlight matching parens, braces, brackets, etc
set hlsearch incsearch ignorecase smartcase " http://vim.wikia.com/wiki/Searching
set scrolloff=2 " number of lines offset when jumping
set sidescroll=6 " scroll a bit horizontally when at the end of the line
set noswapfile " don't create temp files
set hidden " open new buffers without saving current modifications (buffer remains open)
set confirm " ask if buffer needs to be saved
set wildmenu wildmode=list:longest,full " http://stackoverflow.com/questions/9511253/how-to-effectively-use-vim-wildmenu
set clipboard=unnamed " Use system clipboard; http://vim.wikia.com/wiki/Accessing_the_system_clipboard

syntax on " syntax highlighting

" file type recognition
filetype on
filetype plugin on
filetype indent on

" -------------------------------------
"  Neovide
let g:neovide_cursor_vfx_mode = "railgun"

" =====================================
" Plugins
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  " If vim-plug is absent, download it and install plugins
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet data_dir

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" -------------------------------------
" Editing
Plug 'editorconfig/editorconfig-vim' " https://github.com/editorconfig/editorconfig-vim 
Plug 'tpope/vim-repeat' " https://github.com/tpope/vim-repeat
Plug 'tpope/vim-surround' " https://github.com/tpope/vim-surround
Plug 'tpope/vim-commentary' " https://github.com/tpope/vim-commentary
Plug 'tpope/vim-endwise' " https://github.com/tpope/vim-endwise
Plug 'tpope/vim-speeddating' " https://github.com/tpope/vim-speeddating
Plug 'junegunn/vim-peekaboo' " https://github.com/junegunn/vim-peekaboo
"Plug 'svermeulen/vim-easyclip " https://github.com/svermeulen/vim-easyclip
"Plug 'dhruvasagar/vim-table-mode' " https://github.com/dhruvasagar/vim-table-mode

" -------------------------------------
" Tool Integrations
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim' " https://github.com/junegunn/fzf.vim/
Plug 'airblade/vim-gitgutter' " https://github.com/airblade/vim-gitgutter/
Plug 'tpope/vim-fugitive' " https://github.com/tpope/vim-fugitive
Plug 'junegunn/gv.vim' " https://github.com/junegunn/gv.vim

" -------------------------------------
" Look'n'Feel
Plug 'morhetz/gruvbox' " https://github.com/morhetz/gruvbox
Plug 'itchyny/lightline.vim' " https://github.com/itchyny/lightline.vim
Plug 'tpope/vim-sensible' " https://github.com/tpope/vim-sensible
"Plug 'tpope/vim-unimpaired' " https://github.com/tpope/vim-unimpaired
Plug 'preservim/nerdtree' " https://github.com/preservim/nerdtree
Plug 'mbbill/undotree' " https://github.com/mbbill/undotree

" devicons are last so it integrates with everything correctly
Plug 'ryanoasis/vim-devicons' " https://github.com/ryanoasis/vim-devicons

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" =====================================
" Plugin Configuration

" Gruvbox
set bg=dark
autocmd vimenter * ++nested colorscheme gruvbox " Enables gruvbox

" Fzf

let g:fzf_buffers_jump = 1 " [Buffers] Jump to the existing window if possible

" =====================================
" Keybinds
" http://stackoverflow.com/questions/3776117/what-is-the-difference-between-the-remap-noremap-nnoremap-and-vnoremap-mapping#answer-3776182
" http://stackoverflow.com/questions/22849386/difference-between-nnoremap-and-inoremap#answer-22849425

let mapleader = " "
" -------------------------------------
" Commands: <leader>:
nnoremap <leader>:: :Commands<CR>
nnoremap <leader>:h :History:<CR>
" -------------------------------------
" Help: <leader>h
nnoremap <leader>hh :help<space>
nnoremap <leader>ht :Helptags<CR>
nnoremap <leader>hk :Maps<CR>
" -------------------------------------
" Search: <leader>/
nnoremap <leader>/- :nohl<CR>
nnoremap <leader>// :BLines<CR>
nnoremap <leader>/? :Blines<space>
nnoremap <leader>/b :Lines<CR>
nnoremap <leader>/B :Lines<space>
nnoremap <leader>/h :History/<CR>
" -------------------------------------
" Files: <leader>f
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fF :Files<space>
nnoremap <leader>fr :History<CR>
nnoremap <leader>fe :Filetypes<CR>
nnoremap <leader>fg :Rg<space>
nnoremap <leader>ft :NERDTreeToggle<CR>
nnoremap <leader>fv :edit $MYVIMRC<CR>
" -------------------------------------
" Editing: <leader>e
" Paste from system clipboard - not needed already using it by default
"nnoremap <leader>ep "+p
"nnoremap <leader>eP "+P
" Undo Tree
nnoremap <leader>eu :UndotreeToggle<CR>
nnoremap <leader>em :Marks<CR>
" -------------------------------------
" Buffers: <leader>b
nnoremap <silent> <C-PageUp> :bprevious<CR>
nnoremap <silent> <C-PageDown> :bnext<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <leader>bw :w<CR>
" -------------------------------------
" Windows: <leader>w
nnoremap <leader>ww :Windows<CR>

