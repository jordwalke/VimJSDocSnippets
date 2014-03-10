VimJSDocSnippets
=============


Automatically create JSDoc comments for functions using UltiSnips

**Installation**

- Ensure that `UltiSnips` is installed, then install `JSDocSnippets` (this plugin) using `Vundle` or `NeoBundle`.


        " Using Vundle
        Bundle 'SirVer/ultisnips'
        Bundle 'jordwalke/JSDocSnippets'

        " Or if using NeoBundle(recommended)
        NeoBundle 'SirVer/ultisnips'
        NeoBundle 'jordwalke/JSDocSnippets'

- Define your desired keyboard mapping in a `.vimrc` file:

        let g:JSDocSnippetsMapping='<D-C>'



**Usage**



Assuming the keyboard mapping above, place your cursor on the line immediately
above any function, and press the keyboard mapping `Command + shift + c`.

    var myFunc = function(one, two) {
      // ...
    }


Snippets will expand for all of the parameters, and you'll be able to tab
through all of them as you would with any other snippet.

    /**
     * @param {varType} one Description
     * @param {varType} two Description
     * @return {void} description
     */
    var myFunc = function(one, two) {
      // ...
    }

`JSDocSnippets` also works with `ES6` fat arrow functions.

    var myFatArrowFunc = (one, two) => {
      // ...
    }


    /**
     * @param {varType} one Description
     * @param {varType} two Description
     * @return {void} description
     */
    var myFatArrowFunc = (one, two) => {
      // ...
    }



**Support**


Only tested on MacVim, but probably works in other environments. The JSDoc formatting is not customizable yet - pull requests encouraged. This script was simply thrown together to scratch an itch.

These two examples were used as a starting point:

http://stackoverflow.com/questions/7942738/vim-plugin-to-generate-javascript-documentation-comments
https://github.com/distracteddev/jsDocBlock/commit/7994b9c576a010bd2cacd24358454a8879586594

