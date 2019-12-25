function prompt_char {
	if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

PROMPT='%(!.%{$fg_bold[blue]%}.%{$fg_bold[blue]%}%n@)%m %{$fg_bold[yellow]%}%(!.%1~.%~)%{$fg_bold[red]%} $(git_prompt_info)%{$fg_bold[blue]%}$(prompt_char)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX=") "
