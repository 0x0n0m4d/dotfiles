function gd --wraps=git\ diff\ --name-only\ --relative\ --diff-filter=d\ \ \|\ xargs\ batcat\ --diff\ --theme\ \'Nord\' --description alias\ gd=git\ diff\ --name-only\ --relative\ --diff-filter=d\ \ \|\ xargs\ batcat\ --diff\ --theme\ \'Nord\'
    git diff --name-only --relative --diff-filter=d $argv | xargs batcat --diff --theme Nord

end
