#!/bin/sh
set -e

# Default values
KOHYA_LISTEN_ADDRESS=${KOHYA_LISTEN_ADDRESS:-"0.0.0.0"}
KOHYA_SERVER_PORT=${KOHYA_SERVER_PORT:-"7860"}
JUPYTER_IP=${JUPYTER_IP:-"0.0.0.0"}
JUPYTER_PORT=${JUPYTER_PORT:-"8888"}
JUPYTER_PASSWORD=${JUPYTER_PASSWORD:-""}

# Start Kohya's GUI in the background
python3 kohya_gui.py \
    --listen "${KOHYA_LISTEN_ADDRESS}" \
    --server_port "${KOHYA_SERVER_PORT}" \
    --headless \
    --noverify &

# Start JupyterLab in the foreground
# It will read JUPYTER_PASSWORD from the environment
exec jupyter lab \
    --ip="${JUPYTER_IP}" \
    --port="${JUPYTER_PORT}" \
    --allow-root \
    --ServerApp.password="${JUPYTER_PASSWORD}"

