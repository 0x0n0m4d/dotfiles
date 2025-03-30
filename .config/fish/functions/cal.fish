function cal --wraps="bash -c 'if [ -t 1 ] ; then ncal -b ; else /usr/bin/cal ; fi'" --wraps='ncal -b' --description 'alias cal=ncal -b'
  ncal -b $argv
        
end
