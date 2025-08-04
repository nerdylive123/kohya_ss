#!/bin/bash
set -e

# Default values
KOHYA_LISTEN_ADDRESS=${KOHYA_LISTEN_ADDRESS:-"0.0.0.0"}
KOHYA_SERVER_PORT=${KOHYA_SERVER_PORT:-"7860"}
JUPYTER_PORT=${JUPYTER_PORT:-"8888"}
LOG_DIR=${LOG_DIR:-"/app/logs"}

# Start Kohya's GUI in the background
python3 kohya_gui.py \
    --listen "${KOHYA_LISTEN_ADDRESS}" \
    --server_port "${KOHYA_SERVER_PORT}" \
    --headless \
    --noverify &

JUPYTER_PASSWORD=${JUPYTER_PASSWORD:-${JUPYTER_LAB_PASSWORD:-}}

mkdir -p "$LOG_DIR"

    # Use array for complex command
jupyter_cmd=(
        jupyter lab
        --allow-root
        --no-browser
        --port="$JUPYTER_PORT"
        --ip=*
        --FileContentsManager.delete_to_trash=False
        --ContentsManager.allow_hidden=True
        --ServerApp.terminado_settings='{"shell_command":["/bin/bash"]}'
        --ServerApp.token="${JUPYTER_PASSWORD}"
        --ServerApp.password="${JUPYTER_PASSWORD}"
        --ServerApp.allow_origin=*
        --ServerApp.preferred_dir=/workspace
    )

# Start Jupyter Lab
exec "${jupyter_cmd[@]}" 2>&1 | tee "$LOG_DIR/jupyter.log"
