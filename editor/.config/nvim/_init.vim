" Teach a man to fish, and fuck up his terminal experience
set shell=/bin/bash
let mapleader =","

""" Basics 
	set nocompatible   					  " I ain't Bill Joy
	set rtp+=~/.vim/bundle/Vundle.vim 	  " Plug me daddy
	filetype plugin indent on 			  " Turn on nice things 
	set tabstop=4 						  " Thicc
	set shiftwidth=4
	set textwidth=79
	set background=dark
	set number relativenumber
	set termguicolors
	set nohlsearch
	set clipboard=unnamedplus 			  " X window clipboard
	"set t_8f=^[[38;2;%lu;%lu;%lum        " set foreground color
	"set t_8b=^[[48;2;%lu;%lu;%lum        " set background color
	"set t_Co=256
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " No auto comment
	set splitbelow 
	set splitright
	set breakindent 
	set wrap
	set formatoptions-=t " Keep visual textwidth, but no newlines
	set linebreak
	set ignorecase " Need both of these. Case insensitive searching.
	set smartcase  " Need both of these.
	set switchbuf=useopen,usetab,newtab " For makefile tab jumping
	set mouse=
	set undodir=~/.vimdid
	set undofile

	""" Mappings
	map <leader>o :setlocal spell! spelllang=en_us<CR>
	map <C-n> :NERDTreeToggle<CR>
	inoremap <leader>d <ESC>bdwi

	" 'Zooming' with new tabs
	nmap <Leader>zi :tabnew %<CR>
	nmap <Leader>zo :tabclose<CR>

	" Build the document using aliased script
	map <leader>b :!sh ~/scripts/compiler.sh <c-r>%<CR> 
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTREE") && b:NERDTree.isTabTree()) | q | endif
	map <leader>g :Goyo <CR> 
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l
	autocmd VimLeave *.tex !~/scripts/texclear.sh %
	nnoremap S :%s//g<Left><Left>
	
	" Navigating with guides
	inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
	map      <leader><leader> <Esc>/<++><Enter>"_c4l				

	" Java / C comments
	" Single line and function header respectively
	inoremap <leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
	map 	 <leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
	inoremap <leader>c <Esc>i/**<CR>* <++><CR>* Pre-condition: <++><CR>* Post-condition: <++><CR>*<CR>*/<ESC>?<++><CR>nn"_c4l

	" C brace folding, disable multi-line comment folding
	let c_no_comment_fold = 1
	set foldmethod=syntax
	set foldtext=MyFoldText()

	function MyFoldText()
	  let line = getline(v:foldstart)
	  let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
	  return v:folddashes . sub
	endfunction

	set fillchars=fold:\ 
	" Java / C function parantheses 
	inoremap <leader>f <CR>{<CR><++><CR>}<Esc>/<++><CR>c4l

	" GIT
	map <leader>Gc :term git commit<CR> 
	map <leader>Gp :term git push<CR>
	map <leader>Ga :term git add %<CR>

	" open quickfix window automatically when AsyncRun is executed
	" set the quickfix window 6 lines height.
	let g:asyncrun_open = 18 
	 
	" F10 to toggle quickfix window
	nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
	 
	noremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

	noremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

""" Plugins 
	call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'       " Plugin manager
	Plugin 'Valloric/YouCompleteMe'     " Ugh
	Plugin 'liuchengxu/space-vim-dark'  " Looks cool
	Plugin 'scrooloose/nerdtree'	    " Hackerman
	Plugin 'tpope/vim-sensible'		    " Sensible defaults
	Plugin 'scrooloose/syntastic'	    " Syntax highlighting for most things
	Plugin 'Shougo/deoplete.nvim'	    " Async completion engine
	Plugin 'vimwiki/vimwiki'		    " Keep my life in check
	Plugin 'tpope/vim-surround'		    " Not vim without this
	Plugin 'tpope/vim-markdown'		    " Better markdown
	Plugin 'dhruvasagar/vim-table-mode' " Worse markdown
	Plugin 'lifepillar/vim-solarized8'  " FOTM
	Plugin 'junegunn/goyo.vim'			" Distraction free
	Plugin 'mhinz/vim-startify'			" Cow fortunes

	Plugin 'https://github.com/Ron89/thesaurus_query.vim' 
	Plugin 'soli/prolog-vim'	      " Prolog syntax highlighting
	Plugin 'junegunn/fzf.vim'		  " Fuzzy finder 
	Plugin 'skywind3000/asyncrun.vim' " Async operations (deprecated)
	call vundle#end()

""" Plugin specific stuff
	let g:goyo_height=100

""" --- Colour 
	colorscheme solarized8 " space-vim-dark
	syntax on 
	set autochdir

""" File specific stuff
augroup XML
	autocmd!
	autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

augroup collumnLimit
	autocmd!
	autocmd BufEnter,WinEnter,FileType scala,java,c
	\ highlight CollumnLimit ctermbg=DarkGrey guibg=DarkGrey
	let collumnLimit = 79 " feel free to customize
	let pattern =
	\ '\%<' . (collumnLimit+1) . 'v.\%>' . collumnLimit . 'v'
	autocmd BufEnter,WinEnter,FileType scala,java
	\ let w:m1=matchadd('CollumnLimit', pattern, -1)
augroup END

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki', 'path_html': '~/Dropbox/notepage', 'custom_wiki2html': '~/scripts/wiki2html.sh', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd FileType html inoremap ;i <em></em><Space><++><Esc>FeT>i

""" File specific remapping 
	let g:filetype_pl="prolog"

""" Make file BS
fun! SetMkfile()
  let filemk = "Makefile"
  let pathmk = "./"
  let depth = 1
  while depth < 4
    if filereadable(pathmk . filemk)
      return pathmk
    endif
    let depth += 1
    let pathmk = "../" . pathmk
  endwhile
  return "."
endf

command! -nargs=* Make | let $mkpath = SetMkfile() | make <args> -C $mkpath | cwindow 10 
" Markdown 

" LaTeX 

" HTML

" C 
	" Comment style
	autocmd FileType *.c inoremap   <leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
	autocmd FileType *.c map 	 	<leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
	autocmd FileType c map 			<leader>b <Esc>:wall<CR>:Make<CR>

" Java 
	
	autocmd FileType *.java map 	 <leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
	autocmd FileType *.java map 	 <leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
	autocmd FileType *.java setlocal foldmethod=indent

" Go 

" Battlescribe 
augroup cat
	autocmd!
	autocmd FileType cat setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

