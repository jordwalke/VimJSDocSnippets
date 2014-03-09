" Plugin based on SO question:
" http://stackoverflow.com/questions/7942738/vim-plugin-to-generate-javascript-documentation-comments
"
" Plugin:
" https://github.com/distracteddev/jsDocBlock/commit/7994b9c576a010bd2cacd24358454a8879586594
"
" Simple `{` mapping to create indented object keys.
" TODO: Create mapping so that `{` creates:
"   {key: val} with `key` highlighted. Pressing enter would insert a newline,
"   upon which the snippet will dynamically balance, based on snippet.rv (like
"   we do with tags!)
"
" inoremap <silent> { {<C-R>=UltiSnips_Anon("{\n\t${1:key}\n}", '{')<cr>
"
" Here's a close one that almost does brace completion:
" But indenting gets messed up as you type. It might be better to start off
" expanded and then contract if backspace is pressed as opposed to this.
" inoremap <silent> { {<C-R>=UltiSnips_Anon("{${1:key}: ${2:val}`!p snip.rv = '' if not t[1].startswith('\\n') else '\\n'`}$0", '{')<cr>
"

function! JSDocSnippetForLineBelow()
  " if strpart(getline('.'), col('.') - 2, 1) == "\n"
    let l    = line('.') + 1
    " let i    = indent(l)
    " let pre  = repeat(' ',i)
    let placeHolderCount = 1
    let text = getline(l)
    let params   = matchstr(text,'([^)]*)')
    let funcPat = 'function\|=>'
    let paramPat = '\([$a-zA-Z_0-9]\+\)[, ]*\(.*\)'
    let funcMatch = matchstr(text, funcPat)
    " echomsg params
    if funcMatch == "function" || funcMatch == "=>"
      let vars = []
      let m    = ' '
      let ml = matchlist(params,paramPat)
      while ml!=[]
        let [_,var;rest]= ml
        let vars += [' * @param {${'.placeHolderCount.':varType}} '.var.' ${'.(placeHolderCount+1).':Description}']
        let placeHolderCount = placeHolderCount+2
        let ml = matchlist(rest,paramPat,0)
      endwhile

      let beforeReturn = join(['/**'] + vars, "\n")
      let retLine = "\n * ${".placeHolderCount.":@return {${".(placeHolderCount+1).":void}} ${".(placeHolderCount+2).":description}}\n"
      let comment = beforeReturn.retLine." */"
      " echoerr join(comment, "_")
      return comment
    else
      return "/**\n * $0\n */"
    endif
    " call append(l-1,comment)
    " call cursor(l+1,i+3)
  " else
  "   return '/**'
  " endif
endfunction

" Example generated snippet.
" /**\n *\n * @param {${1:varType}} theParam\n * @return $0\n */

" ================= Windows Suggestions ==================:
" To create a consistent feel between mac os x and windows,
" install the following in AutoHotkey.ahk
"
" ; Vim specific mappings (last #IfWinActive clears the check)
" ; Open windows spy to see which class is in effect.
" #IfWinActive ahk_class Vim
" !=::Send ^{Up} ; For increase font size
" !-::Send ^{Down} ; For decrease font size
" !t::F8; For CMD+t equivalent
" !r::F9; For CMD+r equivalent
" !+r::F10 ; For CMD+R equivalent
" !e::F11; For CMD+e equivalent
" !p::F12; For CMD+p equivalent
" !c::Send {M-c}
" !+c::Send +{M-c}
" #IfWinActive
"=====================================================
if has('gui_win32')
  inoremap <silent> <S-M-c> {<C-R>=UltiSnips#Anon(JSDocSnippetForLineBelow(), '{')<cr>
else
  inoremap <silent> <D-C> {<C-R>=UltiSnips#Anon(JSDocSnippetForLineBelow(), '{')<cr>
endif
