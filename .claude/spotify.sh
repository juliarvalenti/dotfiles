#!/bin/bash
osascript -e 'tell application "Spotify" to if it is running then return "♫ " & artist of current track & " — " & name of current track' 2>/dev/null || echo ""
