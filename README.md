# Sojharo's Dotfiles
Dotfile configurations for my development environment (under active development)

# Usage
These configurations are done according to my taste. Please go through these and learn from documentation to
understand your own unique needs. Try to understand each line before using them. It is better to comment all
the lines out and then uncomment them one by one and see the changes to your environment. Keep those which you
find necessary for you. Don't just use the whole files as it is.

## Dependencies for VIM
I have tried my best to use as less external plugins as possible. So, these configuration files won't break if you use the whole files as it is. However, there are following two plugins which are configured in vimrc.

- Ale plugin for JavaScript linting and formatting using Standardjs.
- Coc.nvim for Intellisense support

If you don't need that, just remove the lines under Plugin Settings in vimrc file.

Also, in vimrc file, I am using a color scheme which I had downloaded from external source. You should 
download that color scheme or just use the built-in themes which come with vim editor.

## Vim Configuration

![img](https://github.com/sojharo/dotfiles/blob/master/docs/vim.png)

## Tmux Configuration

![img](https://github.com/sojharo/dotfiles/blob/master/docs/tmux.png)

### TODO

- .gitconfig (inspiration from https://medium.com/usevim/git-and-vimdiff-a762d72ced86)
- intellisense for vim https://www.freecodecamp.org/news/a-guide-to-modern-web-development-with-neo-vim-333f7efbf8e2/

### Other Vim External Plugins used (Not required)

The following plugins are used by me on my local machine. These are not required in my configuration files. These are just to make my development environment more pleasant. I am listing them here so that they may inspire someone.

- Vim Polyglot
