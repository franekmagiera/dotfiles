abbr -a e nvim
abbr -a g git
abbr -a gc 'git commit -m'
abbr -a ga 'git add --patch'
abbr -a gst 'git status --short'
abbr -a glo 'git log --oneline'

if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting

[ -f $HOMEBREW_PREFIX/share/autojump/autojump.fish ]; and source $HOMEBREW_PREFIX/share/autojump/autojump.fish

pyenv init - | source

