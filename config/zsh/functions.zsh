function portforward() {
  local PORT="$1"
  local MACHINE="${2:-thekooziejr}"
  local SESSION_NAME="${MACHINE}-${PORT}"

  screen -dmS "$SESSION_NAME" ssh -L "${PORT}:localhost:${PORT}" "${MACHINE}"

  # Give a brief moment for the screen session to potentially terminate on failure
  sleep 1

  # Check if the screen session exists
  if screen -list | grep -q "$SESSION_NAME"; then
    echo "Port forwarding session started. Port: ${PORT}, Machine: ${MACHINE}"
  else
    echo "Error: Failed to start port forwarding session. Check the connection details."
  fi
}

