function bper --wraps='cat /sys/class/power_supply/BAT1/capacity' --description 'alias bper=cat /sys/class/power_supply/BAT1/capacity'
    cat /sys/class/power_supply/BAT1/capacity $argv
end
