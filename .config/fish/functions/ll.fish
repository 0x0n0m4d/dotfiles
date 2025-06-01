function ll --wraps=ls --wraps='eza -la -s extension --group-directories-first --header --icons=always' --description 'alias ll=eza -la -s extension --group-directories-first --header --icons=always'
    eza -la -s extension --group-directories-first --header --icons=always $argv

end
