#!/usr/bin/sh

# Terminate all running instances
killall -q polybar

# Wait until they have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch 'bar'
# 'Bar' is the name set in the polybar config, 
# so you have to change it here if you change it there
polybar bar

echo "Bars launched.."
