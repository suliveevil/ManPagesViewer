" Vim syntax file
"  Language:	Manpageview
"  Maintainer:	Charles E. Campbell
"  Last Change:	Apr 05, 2013 - Oct 12, 2021
"  Version:    	8	ASTRO-ONLY
"
"  History:
"    8: * more option highlighting
"    	* subsection highlighting
"    2: * Now has conceal support
"       * complete substitute for distributed <man.vim>
" ---------------------------------------------------------------------
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif
if !has("conceal")
 " hide control characters, especially backspaces
 if version >= 600
  run! syntax/ctrlh.vim
 else
  so <sfile>:p:h/ctrlh.vim
 endif
endif

syn case ignore
" following four lines taken from Vim's <man.vim>:
syn match  manNotSpecial	'^\s*Then$'
syn match  manSubSectionHeading	'^\s*\zs\(\u\l\+\s*\)\+[.:]\=$'
syn match  manSubSectionHeading	'^\u\l\+\s*\(\l\+\s*\)\+[.:]\=$'
syn match  manReference		"\f\+([1-9]\l\=)"
syn match  manSectionTitle	'^\u\{2,}\(\s\+\u\{2,}\)*'
"syn match  manSubSectionTitle	'^\s+\zs\u\{2,}\(\s\+\u\{2,}\)*'
syn match  manTitle		"^\f\+([0-9]\+\a\=).*"
syn match  manSectionHeading	"^\(\u\l\+\s\)\+$"
syn match  manOption		"^\s*\zs[-+]\{1,2}\w[-a-zA-Z_=]*"	  nextgroup=manOptionSep
syn match  manOptionSep		contained ','			skipwhite nextgroup=manMoreOption
syn match  manMoreOption	contained "[-+]\{1,2}\w\S*"		  nextgroup=manOptionSep

syn match  manSectionHeading	"^\s\+\d\+\.[0-9.]*\s\+\(\u\l\+\s*\)\+$"  contains=manSectionNumber
syn match  manSectionHeading	'\<Exit status:\|SELinux options:'
syn match  manSectionNumber	"^\s\+\d\+\.\d*"			contained
syn region manDQString		start='[^a-zA-Z"]"[^", )]'lc=1		end='"'		end='^$' contains=manSQString
syn region manSQString		start="[ \t]'[^', )]"lc=1		end="'"		end='^$'
syn region manSQString		start="^'[^', )]"lc=1			end="'"		end='^$'
syn region manBQString		start="[^a-zA-Z`]`[^`, )]"lc=1		end="[`']"	end='^$'
syn region manBQString		start="^`[^`, )]"			end="[`']"	end='^$'
syn region manBQSQString	start="``[^),']"			end="[`']['`]"	end='^$'
syn match  manBulletZone	"^\s\+o\s"				transparent contains=manBullet
syn case match

syn keyword manBullet		o					contained
syn match   manBullet		"\[+*]"					contained
syn match   manSubSectionStart	"^\*"					skipwhite nextgroup=manSubSection
syn match   manSubSection	".*$"					contained
syn match   manOptionWord	"\s[-+]\a\+\>"				skipwhite nextgroup=manOptionSep

if has("conceal")
 setlocal cole=3
 syn match manSubTitle		/\(.\b.\)\+/	contains=manSubTitleHide
 syn match manUnderline		/\(_\b.\)\+/	contains=manSubTitleHide
 syn match manSubTitleHide	/.\b/		conceal contained
endif

" my RH8 linux's man page puts some pretty oddball characters into its
" manpages...
silent! %s/???/'/ge
silent! %s/???/-/ge
silent! %s/???$/-/e
silent! %s/???/`/ge
silent! %s/???/-/ge
norm! 1G

set ts=8

com! -nargs=+ HiLink hi def link <args>

HiLink manTitle			Title
"  HiLink manSubTitle		Statement
HiLink manUnderline		Type
HiLink manSectionHeading	Statement
HiLink manSubSectionHeading	manSubTitle
HiLink manOption		Constant
HiLink manOptionWord		manOption
HiLink manMoreOption		manOption

HiLink manReference		PreProc
HiLink manSectionTitle		Function
HiLink manSectionNumber		Number
HiLink manDQString		String
HiLink manSQString		String
HiLink manBQString		String
HiLink manBQSQString		String
HiLink manBullet		Special
if has("win32") || has("win95") || has("win64") || has("win16")
 if &shell == "bash"
  hi manSubSectionStart		term=NONE	cterm=NONE      gui=NONE      ctermfg=black ctermbg=black guifg=navyblue guibg=navyblue
  hi manSubSection		term=underline	cterm=underline gui=underline ctermfg=green guifg=green
  hi manSubTitle		term=NONE	cterm=NONE      gui=NONE      ctermfg=cyan  ctermbg=blue  guifg=cyan     guibg=blue
 else
  hi manSubSectionStart		term=NONE	cterm=NONE      gui=NONE      ctermfg=black ctermbg=black guifg=black    guibg=black
  hi manSubSection		term=underline	cterm=underline gui=underline ctermfg=green guifg=green
  hi manSubTitle		term=NONE	cterm=NONE      gui=NONE      ctermfg=cyan  ctermbg=blue  guifg=cyan     guibg=blue
 endif
else
 hi manSubSectionStart	term=NONE	cterm=NONE      gui=NONE      ctermfg=black ctermbg=black guifg=navyblue guibg=navyblue
 hi manSubSection	term=underline	cterm=underline gui=underline ctermfg=green guifg=green
 hi manSubTitle		term=NONE	cterm=NONE      gui=NONE      ctermfg=cyan  ctermbg=blue  guifg=cyan     guibg=blue
endif

delcommand HiLink

let b:current_syntax = "man"

" vim:ts=8
