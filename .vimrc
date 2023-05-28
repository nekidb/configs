set autowrite
set nu
set rnu
set tabstop=4
set shiftwidth=4
set updatetime=100

let mapleader = ","
let maplocalleader = "."

" ========
" Mappings
" ========

" go to Normal mode
:inoremap jk <esc>

" go to start/end of line
:nnoremap H 0
:nnoremap L $

" word in quotes
:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel

" fast edit vimrc
:noremap <leader>ev :vsp $MYVIMRC<cr>
:noremap <leader>sv :source $MYVIMRC<cr>

" move line up/down
:nnoremap <leader>- ddp
:noremap <leader>_ ddkP

" word to Upper/Lower
:nnoremap <leader>u viwUw
" :nnoremap <leader>l viwLw

" insert current timestamp (like in Windows notepad)
:nnoremap <F5> "=strftime("%H:%M %F")<cr>Pa;
:inoremap <F5> <C-R>=strftime("%H:%M %F")<cr>;

" quit current buffer
:nnoremap bc :b#<bar>bd#<CR>  


" =======
" Plugins
" =======
call plug#begin()
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'preservim/nerdtree'
" Plug 'fatih/molokai'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
"
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

call plug#end()

let g:deoplete#enable_at_startup = 1

let g:rehash256 = 1
" let g:molokai_original = 1
" colorscheme molokai
colorscheme dracula

" NERDTree commands
:nnoremap <leader>n :NERDTreeToggle<CR>


" ======
" Golang
" ======

let g:go_auto_type_info = 1
let g:go_fmt_command = "goimports"
" let g:go_highlight_function_calls = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_fields = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

" comment/uncomment
autocmd FileType go nnoremap <leader>c I// <esc>  
autocmd FileType go vnoremap <leader>c ^<c-v>I// <esc>
autocmd FileType go nnoremap <localleader>c ^xxx$
autocmd FileType go vnoremap <localleader>c <c-v>llx$

" documentation
autocmd FileType go nmap <leader>gd <Plug>(go-decls-dir)
autocmd FileType go nmap <leader>gf <Plug>(go-decls)
" autocmd FIleType go nmap <leader>i <Plug>(go-info)

" testing
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
" autocmd FileType go nmap <leader>c <Plug>(go-coverage)
" autocmd FileType go nmap <leader>c! <Plug>(go-coverage-clear)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
	let l:file = expand('%')
	if l:file =~# '^\f\+_test\.go$'
		call go#test#Test(0, 1)
	elseif l:file =~# '^\f\+\.go$'
		call go#cmd#Build(0)
	endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
