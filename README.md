# Sojharo's Dotfiles

Dotfile configurations for my development environment (under active development)

# Usage

These configurations are done according to my taste. Please go through these and learn from documentation to
understand your own unique needs. Try to understand each line before using them. It is better to comment all
the lines out and then uncomment them one by one and see the changes to your environment. Keep those which you
find necessary for you. Don't just use the whole files as it is.

## Dependencies for VIM

I have tried my best to use as less external plugins as possible. So, these configuration files won't break if you use the whole files as it is. However, there are following plugins which are configured in vimrc.

- Vim-Polyglot
- Coc.nvim for Intellisense support
- Git Messenger https://github.com/rhysd/git-messenger.vim
- Copilot https://github.com/github/copilot.vim

If you don't need that, just remove the lines under Plugin Settings in vimrc file.

Also, in vimrc file, I am using a color scheme which I had downloaded from external source. You should
download that color scheme or just use the built-in themes which come with vim editor.

## Vim Configuration

![img](https://github.com/sojharo/dotfiles/blob/master/docs/vim.png)

## Tmux Configuration

![img](https://github.com/sojharo/dotfiles/blob/master/docs/tmux.png)

### For using vimrc file for neovim

Run following commands assuming dotfiles repo is cloned in home directory

    mkdir ~/.config/nvim
    cd ~/.config/nvim
    ln -s ~/dotfiles/nvimrc init.vim

### TODO

- https://samroeca.com/coc-plugin.html
- https://github.com/junegunn/fzf
- https://www.quora.com/Is-there-a-Vim-plugin-that-lets-you-easily-see-the-git-blame-on-the-files-you-are-editing

### Other tools I use that may not be configured here.

- CTop
- K9s
- fzf
- tree
- bat (using for fzf)
- fd (using for fzf, maybe replace with ripgrep later)

### References

- .gitconfig (inspiration from https://medium.com/usevim/git-and-vimdiff-a762d72ced86)
- https://www.freecodecamp.org/news/vim-for-people-who-use-visual-studio-code/
