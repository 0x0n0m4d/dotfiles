function tree --wraps='eza --tree --icons' --wraps='eza --tree --icons -s extension --group-directories-first' --description 'alias tree=eza --tree --icons -s extension --group-directories-first'
  eza --tree --icons -s extension --group-directories-first $argv
        
end
