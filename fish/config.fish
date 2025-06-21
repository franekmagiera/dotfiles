abbr -a e nvim
abbr -a g git
abbr -a ga 'git add --patch'
abbr -a gs 'git status --short'
abbr -a glo 'git log --oneline'
abbr -a gd 'git diff'
abbr -a gdc 'git diff --cached'
abbr -a gdt 'git difftool'
abbr -a tree 'tree -C'

if command -v eza > /dev/null
	abbr -a l 'eza'
	abbr -a ls 'eza'
	abbr -a ll 'eza -l'
	abbr -a lll 'eza -la'
else
	abbr -a l 'ls'
	abbr -a ll 'ls -l'
	abbr -a lll 'ls -la'
end

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

