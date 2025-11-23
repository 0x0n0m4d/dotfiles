#!/bin/sh

INTERFACE="wlan0"
SSID=$(iw dev | grep ssid | awk '{print $2}')
CACHE_DIR="/tmp/i3blocks_network"

if [ ! -d $CACHE_DIR ]; then
    mkdir -p $CACHE_DIR
fi

RX_FILE="$CACHE_DIR/${INTERFACE}_rx"
TX_FILE="$CACHE_DIR/${INTERFACE}_tx"

if [ ! -f $RX_FILE ] || [ ! -f $TX_FILE ]; then
    OUT=$(awk -v i="$INTERFACE" '$0 ~ i {print $2, $10}' /proc/net/dev)
    CURR_RX=$(echo $OUT | awk '{print $1}')
    CURR_TX=$(echo $OUT | awk '{print $2}')
    echo "$CURR_RX" >"$RX_FILE"
    echo "$CURR_TX" >"$TX_FILE"
fi

if [ ! -d "/sys/class/net/${INTERFACE}/" ] || [ ! -f "/sys/class/net/${INTERFACE}/operstate" ]; then
    echo "<span bgcolor='#cc241d' color='#282828'>    </span>\n"
elif [ -z $SSID ]; then
    echo "<span bgcolor='#cc241d' color='#282828'>  󰤭   </span>\n"
else
    SIGNAL=$(iw dev $INTERFACE link | grep signal | awk '{print $2}')

    if [ -z $SIGNAL ] || [ $SIGNAL -le -90 ]; then
        PERCENTAGE=0
    elif [ $SIGNAL -gt -30 ]; then
        PERCENTAGE=100
    else
        PERCENTAGE=$((100 * (SIGNAL + 90) / 60))
    fi

    BG_COLOR="#d3869b"
    if [ $PERCENTAGE -gt 80 ]; then
        SYMBOL="󰤨"
    elif [ $PERCENTAGE -gt 50 ]; then
        SYMBOL="󰤥"
    elif [ $PERCENTAGE -gt 25 ]; then
        SYMBOL="󰤢"
    elif [ $PERCENTAGE -gt 10 ]; then
        SYMBOL="󰤟"
        BG_COLOR="#fb4934"
    else
        SYMBOL="󰤯"
        BG_COLOR="#fb4934"
    fi

    OUT=$(awk -v i="$INTERFACE" '$0 ~ i {print $2, $10}' /proc/net/dev)
    CURR_RX=$(echo $OUT | awk '{print $1}')
    CURR_TX=$(echo $OUT | awk '{print $2}')
    PREV_RX=$([ -f "$RX_FILE" ] && cat "$RX_FILE" || echo "$CURR_RX")
    PREV_TX=$([ -f "$TX_FILE" ] && cat "$TX_FILE" || echo "$CURR_TX")
    echo "$CURR_RX" >"$RX_FILE"
    echo "$CURR_TX" >"$TX_FILE"

    RX_SPEED=$(((CURR_RX - PREV_RX) * 8 / 1024))
    TX_SPEED=$(((CURR_TX - PREV_TX) * 8 / 1024))

    if [ $RX_SPEED -gt 1024 ]; then
        RX_SPEED=$((RX_SPEED / 1024))
        if [ $RX_SPEED -gt 1024 ]; then
            RX_SPEED=$((RX_SPEED / 1024))
            RX_UNIT="Gbps"
        else
            RX_UNIT="Mbps"
        fi
    else
        RX_UNIT="Kbps"
    fi
    if [ $TX_SPEED -gt 1024 ]; then
        TX_SPEED=$((TX_SPEED / 1024))
        if [ $TX_SPEED -gt 1024 ]; then
            TX_SPEED=$((TX_SPEED / 1024))
            TX_UNIT="Gbps"
        else
            TX_UNIT="Mbps"
        fi
    else
        TX_UNIT="Kbps"
    fi

    echo "<span bgcolor='$BG_COLOR' color='#282828'>  $SYMBOL $PERCENTAGE% / ▼ ${RX_SPEED}${RX_UNIT} ▲ ${TX_SPEED}${RX_UNIT}  </span>\n"
fi
