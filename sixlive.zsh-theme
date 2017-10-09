ZSH_THEME_GIT_PROMPT_PREFIX="▶︎ "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_ADDED=" %{$fg[cyan]%}✈%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" %{$fg[yellow]%}★%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED=" %{$fg[red]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED=" %{$fg[blue]%}➦%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED=" %{$fg[magenta]%}✂%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✱"

GIT_ROOT () {
    basename $(git rev-parse --show-toplevel)
}

LOWERCASE () {
    echo $1 | sed -E 'y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'
}

PATH_INFO () {
    local HOME_PATH=%~
    if [[ $PWD/ = /Users/* ]]; then
        local HOME_PATH=$(echo $PWD | sed 's/\/Users\/[a-zA-Z]*/▶︎/')
    fi

    local DIR=%{$fg[magenta]%}$HOME_PATH%{$reset_color%}

    if [ -n "$(git_prompt_info)" ]; then
        local ROOT=$(GIT_ROOT)

        if [ $(LOWERCASE "$ROOT") != $(LOWERCASE "${PWD##*/}") ]; then
            DIR="︎%{$fg[magenta]%}$ROOT%{$reset_color%}/${PWD/*$ROOT\//}"
        else
            DIR="$ROOT"
        fi
    fi

    echo "%{$fg[magenta]%}$DIR%{$reset_color%}"
}

PROMPT='$(PATH_INFO) $(git_prompt_info)$(git_prompt_status)
⚡  '
