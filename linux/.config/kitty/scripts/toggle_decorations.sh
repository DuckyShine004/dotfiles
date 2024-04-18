#!/bin/bash
# Script to toggle window decorations in kitty

# Query the current state of hide_window_decorations
current_state=$(kitty @ get-window-decoration)

echo current_state
# Determine the new state to toggle
if [ "$current_state" = "off" ]; then
  new_state="on"
else
  new_state="off"
fi

# Set the new state
kitty @ set-window-decoration "$new_state"
