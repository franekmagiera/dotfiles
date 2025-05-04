abbr -a e nvim
abbr -a g git
abbr -a ga 'git add --patch'
abbr -a gst 'git status --short'
abbr -a glo 'git log --oneline'

if status is-interactive
    # Commands to run in interactive sessions can go here
end

fish_vi_key_bindings

set -g fish_greeting

set -g HOMEBREW_PREFIX /opt/homebrew/
fish_add_path  /opt/homebrew/bin
[ -f $HOMEBREW_PREFIX/share/autojump/autojump.fish ]; and source $HOMEBREW_PREFIX/share/autojump/autojump.fish

pyenv init - | source
fzf --fish | source

set -Ux FZF_ALT_C_OPTS "\
  --walker-skip .git,node_modules,target\
  --preview 'tree -C {}'"

set -Ux FZF_CTRL_T_OPTS "\
  --walker-skip .git,node_modules,target\
  --preview 'cat -n {}'"

