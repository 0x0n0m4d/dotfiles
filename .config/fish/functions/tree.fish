function tree --wraps='eza -la --group-directories-first -s extension --tree --header' --description 'alias tree=eza -la --group-directories-first -s extension --tree --header'
  eza -la --group-directories-first -s extension --tree --header $argv
        
end
