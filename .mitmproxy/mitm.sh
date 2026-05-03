#!/bin/bash

ALLOWED_HOSTS=""
STATIC_FILTER='!(~u "\.(js|css|png|jpg|jpeg|gif|svg|woff2?|ttf|eot|ico|pdf|mp[34]|web[mp])([?].*)?$")'
LISTEN_PORT=8080
INTERFACE=0.0.0.0
SSL_INSPECTION=true

CMD="mitmproxy"
CMD="$CMD --allow-hosts '$ALLOWED_HOSTS'"
CMD="$CMD --view-filter '$STATIC_FILTER'"
CMD="$CMD --listen-port $LISTEN_PORT"
CMD="$CMD --listen-host $INTERFACE"
CMD="$CMD --set console_mouse=false"
CMD="$CMD --set console_focus_follow=true"
CMD="$CMD --set anticomp=true"

if [ "$SSL_INSPECTION" = true ]; then
    CMD="$CMD --ssl-insecure"
fi

CMD="$CMD --anticache"
CMD="$CMD --http2"

eval $CMD
