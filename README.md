# Dobes' NeoVim Config

<!--toc:start-->

- [Dobes' NeoVim Config](#dobes-neovim-config)
  - [My Custom Setup](#my-custom-setup)
  - [Details](#details)
  - [Acknowledgements](#acknowledgements)
  <!--toc:end-->

## My Custom Setup

```
version: 1.2.0
collaborator: Ebod Shojaei (Dobes)
```

## Details

This follows the updated 2024 tutorial by Josean Martinez (real MVP). The file manager UI in treesitter is more aesthetically pleasing :D

My personal touch was the inclusion of a split terminal (`<space>-tt`) for quickly executing programs without closing the current nvim session.

This version removes copilot and is subject for reinclusion if helpful.

Written entirely in Lua, a fun functional programming language, to setup plugins for NeoVim.

Current NeoVim setup with code retyped following tutorials by Josean Martinez (see Acknowledgements).

`lspconfig.lua` was updated to dynamically setup the language servers. All thanks go to Josean Martinez and the wonderful developers in the neovim and lua space.

## Acknowledgements

Special thanks to Josean Martinez for extremely helpful terminal, neovim, and lua tutorials.

> NeoVim Tutorial: https://www.josean.com/posts/how-to-setup-neovim-2024
> TMux Tutorial: https://www.josean.com/posts/tmux-setup
> P10K Tutorial: https://www.josean.com/posts/terminal-setup
> GitHub : https://github.com/josean-dev
> YouTube : https://www.youtube.com/@joseanmartinez
