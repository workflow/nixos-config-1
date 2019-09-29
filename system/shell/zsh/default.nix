{ pkgs, ... }:

let git-prompt = pkgs.callPackage ./git-prompt.nix { };

in {

  programs.zsh = {
    enable = true;
    interactiveShellInit = ''
      # eval "$(stack --bash-completion-script stack)"
      source ${git-prompt}

      nvminit() {
        unset -f npm
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      }
    '';
    promptInit = ''
      prompt_status() {
        local symbols
        symbols=()
        [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{white}%}⚙"
        [[ -n "$symbols" ]] && echo -n "$symbols "
      }

      build_prompt() {
        prompt_status
      }

      symb="$"
      # symb="λ"
      # symb="»"

      local ret_status="%(?:%{$fg_bold[green]%}$symb:%{$fg_bold[red]%}$symb)"
      local root_ret_status="%(?:%{$fg_bold[green]%}#:%{$fg_bold[red]%}#)"
      PROMPT='$(build_prompt)%{$fg[green]%}%~%{$reset_color%}$(git_super_status) %(!.''${root_ret_status}.''${ret_status})%{$reset_color%} '
      PROMPT2='%{$fg[green]%}┌─╼ %{$reset_color%}$(build_prompt)%{$fg[cyan]%}%~%{$reset_color%}$(git_super_status)
      %{$fg[cyan]%}└╼ %(!.''${root_ret_status}.''${ret_status})%{$reset_color%} '
      RPROMPT='[%T]'

      switch_prompts() {
          local tmp=$PROMPT
          PROMPT=$PROMPT2
          PROMPT2=$tmp
      }

      alias sp=switch_prompts
    '';
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "nix" "zsh-completions" ];
    };
  };

}
