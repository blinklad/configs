" Teach a man to fish, and fuck up his terminal experience
set shell=/bin/bash
let mapleader =","

" =============================================================================
" # PLUGINS
" =============================================================================
" Load vundle
set nocompatible
filetype off
set clipboard=unnamedplus
set rtp+=~/.config/configs/editor/.config/.vim/bundle/Vundle.vim
call vundle#begin()

" Load plugins
" VIM enhancements
Plugin 'VundleVim/Vundle.vim'       " Plugin manager
Plugin 'scrooloose/nerdtree'	    " Hackerman
Plugin 'tpope/vim-sensible'		    " Sensible defaults
" Plugin 'scrooloose/syntastic'	    " Syntax highlighting for most things
Plugin 'vimwiki/vimwiki'		    " Keep my life in check
Plugin 'Shougo/deoplete.nvim'	    " Async completion engine
Plugin 'tpope/vim-surround'		    " Not vim without this
Plugin 'https://github.com/Ron89/thesaurus_query.vim' 
Plugin 'mhinz/vim-startify'			" Cow fortunes
Plugin 'romainl/vim-cool'			" Make hlsearch bearable

" GUI enhancements
Plugin 'itchyny/lightline.vim'
Plugin 'w0rp/ale'
Plugin 'machakann/vim-highlightedyank'
Plugin 'andymass/vim-matchup'
Plugin 'chriskempson/base16-vim' " Color scheme templates

" Fuzzy finder
Plugin 'airblade/vim-rooter'
" Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'

" Semantic language support
Plugin 'phildawes/racer'
Plugin 'racer-rust/vim-racer'
Plugin 'ncm2/ncm2'
Plugin 'roxma/nvim-yarp'
Plugin 'sheerun/vim-polyglot'			" Sensible defaults for language packs
Plugin 'vim-jp/vim-cpp'					" Extended C(pp) recognition 
" Plugin 'ludovicchabant/vim-gutentags'   " Generate and update local ctags
Plugin 'vim-scripts/TagHighlight'		" Recognise ctags
Plugin 'autozimu/LanguageClient-neovim', {'do': ':UpdateRemotePlugins'}
" Language server

" Completion Plugin
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-tmux'
Plugin 'ncm2/ncm2-path'

" Syntactic language support
Plugin 'cespare/vim-toml'
Plugin 'rust-lang/rust.vim'
Plugin 'dag/vim-fish'
Plugin 'godlygeek/tabular'

" Aesthetics
Plugin 'lifepillar/vim-solarized8'  " FOTM
Plugin 'junegunn/goyo.vim'			" Distraction free

call vundle#end()


" =============================================================================
"  Colors 
" =============================================================================
if has('nvim')
    set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
    set inccommand=nosplit
    noremap <C-q> :confirm qall<CR>
end

" deal with colors
if !has('gui_running')
  set t_Co=256
endif

if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif

set background=dark
set termguicolors 
colorscheme base16-atelier-dune " solarized8 
" let base16colorspace=256

hi Normal ctermbg=NONE

" Get syntax
syntax on

" =============================================================================
"  Plugin specific stuff 
" =============================================================================

" Plugin settings
let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]

" Distraction free
let g:goyo_height=100

" Lightline
" let g:lightline = { 'colorscheme': 'wombat' }
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" Javascript
let javaScript_fold=0

" Linter
" only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save = 0
let g:ale_lint_on_enter = 0
let g:ale_virtualtext_cursor = 1
let g:ale_rust_rls_config = {
	\ 'rust': {
		\ 'all_targets': 1,
		\ 'build_on_save': 1,
		\ 'clippy_preference': 'on'
	\ }
	\ }
let g:ale_rust_rls_toolchain = ''
let g:ale_linters = {'rust': ['rls']}
let g:ale_sign_error = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info = "i"
let g:ale_sign_hint = "➤"

highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None

nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> <F2> :UpdateTypesFile<CR>

" Jump to next/previous error
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-l> <Plug>(ale_detail)
nmap <silent> <C-g> :close<cr>

" Language client stuff
let g:LanguageClient_serverCommands = {
  \ 'cpp': ['clangd'],
  \ 'c': ['clangd'],
  \ 'rust': ['rustup', 'run', 'nightly', 'rls']
  \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

" Latex
let g:latex_indent_enabled = 1
let g:latex_fold_envs = 0
let g:latex_fold_sections = []

" Quick-save
nmap <leader>w :w<CR>


" =============================================================================
"  Rust
" =============================================================================
" Rust is rust my dude
autocmd BufReadPost *.rs setlocal filetype=rust

" racer + rust
" https://github.com/rust-lang/rust.vim/issues/192
let g:rustfmt_command = "rustfmt +nightly"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1

let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"



" =============================================================================
"  C
" =============================================================================


" Completion
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
" tab to select
" and don't hijack my enter key
inoremap <expr><Tab> (pumvisible()?(empty(v:completed_item)?"\<C-n>":"\<C-y>"):"\<Tab>")
inoremap <expr><CR> (pumvisible()?(empty(v:completed_item)?"\<CR>\<CR>":"\<C-y>"):"\<CR>")

" Golang
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = "goimports"
let g:go_bin_path = expand("~/dev/go/bin")

" =============================================================================
" # Editor settings
" =============================================================================
filetype plugin indent on
set autochdir
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden " Required for operations modifying multiple buffers (eg. rename)
set wrap   " because I'm a gangsta
set nojoinspaces
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1

" Always draw sign column for linter. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.config/configs/editor/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Use wide tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab


" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 'Very magic' vim pattern matching by default
nnoremap ? ?\v
nnoremap / /\v
cnoremap %s/ %sm/

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ruler " Where am I?
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
nnoremap ; :

" Ctrl+c and Ctrl+j as Esc
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>

" Move between splits
nnoremap <leader>l <C-l>
nnoremap <leader>j <C-j>
nnoremap <leader>k <C-k>
nnoremap <leader>h <C-h>

" Find and replace
nnoremap S :%s//g<Left><left>

" Neat X clipboard integration
" ,p will paste clipboard into buffer
" ,c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>
set clipboard=unnamedplus

" <leader>s for Rg search
noremap <leader>s :Rg<CR>
let g:fzf_layout = { 'down': '~20%' }
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': s:list_cmd(),
  \                               'options': '--tiebreak=index'}, <bang>0)


" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" No arrow keys --- force yourself to use the home row
nnoremap <up> <nop>
nnoremap <down> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" <leader>= reformats current tange
nnoremap <leader>= :'<,'>RustFmtRange<cr>

" <leader>, shows/hides hidden characters
nnoremap <leader>, :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" Keymap for replacing up to next _ or -
noremap <leader>m ct_
noremap <leader>n ct-

" I can type :help on my own, thanks.
map <F1> <Esc>
imap <F1> <Esc>

" I can't spell, though
map <leader>o :setlocal spell! spelllang=en_us<CR>

" I'm a hackerman
map <C-n> :NERDTreeToggle<CR>

" 'Zooming' with new tabs
nmap <Leader>zi :tabnew %<CR>
nmap <Leader>zo :tabclose<CR>

" GOOOYOOOO
map <leader>g :Goyo <CR> 

" Navigating between buffers 
nnoremap <leader><leader> <c-^>
inoremap <leader><leader> <c-^>

" TODO Fix the guide navigiation
" inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
" vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
" map      <leader><leader> <Esc>/<++><Enter>"_c4l				

" =============================================================================
" # Autocommands
" =============================================================================

" Clear up tex junk
autocmd VimLeave *.tex !~/.scripts/texclear.sh %

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
"

" Auto-make less files on save
autocmd BufWritePost *.less if filereadable("Makefile") | make | endif

" Follow Rust code style rules
au Filetype rust set colorcolumn=100

" Help filetype detection
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

" Ensure files are read as what I want:
	let g:vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
	let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki', 'path_html': '~/Dropbox/notepage', 'custom_wiki2html': '~/scripts/wiki2html.sh', 'syntax': 'markdown', 'ext': '.md'}]
	autocmd BufRead,BufNewFile *.tex set filetype=tex
	autocmd FileType html inoremap ;i <em></em><Space><++><Esc>FeT>i

" Script plugins
" autocmd Filetype html,xml,xsl,php source ~/.config/nvim/scripts/closetag.vim

" =============================================================================
"  C stuff
" =============================================================================
"
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

" C tags

nnoremap <leader>d <C-]>
nnoremap <leader>b <C-T>

" C snippets 

" Single line and function header respectively
inoremap <leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
map 	 <leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
inoremap <leader>c <Esc>i/**<CR>* <++><CR>* Pre-condition: <++><CR>* Post-condition: <++><CR>*<CR>*/<ESC>?<++><CR>nn"_c4l

" Comment style
autocmd FileType *.c inoremap   <leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
autocmd FileType *.c map 	 	<leader>C <Esc>i/*<++>*/<++><Esc>/<++><Enter>"_c4l
autocmd FileType c map 			<leader>B <Esc>:wall<CR>:Make<CR>

" augroup LSP
"   autocmd!
"   autocmd FileType cpp,c call SetLSPShortcuts()
" augroup END
" Function parantheses 
inoremap <leader>f <CR>{<CR><++><CR>}<Esc>/<++><CR>c4l

" Makes for c projects 
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
" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif

