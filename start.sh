#!/bin/sh

echo "Welcome to ChatNPU!"

# Setup OpenVINO venv
echo "Setting up OpenVINO™ venv..."
python3 -m venv openvino_env
source openvino_env/bin/activate
python -m pip install --upgrade pip
pip install --upgrade openvino==2025.2.0
pip install --upgrade flask
pip install --upgrade --upgrade-strategy eager "optimum[openvino]"

# Check if telemetry file exists and, if not, ask the user to make a choice
TELEMETRYFILE=~/intel/openvino_telemetry
if [ -f "$TELEMETRYFILE" ]; then
    echo -n "OpenVINO™ telemetry is set to " && cat "$TELEMETRYFILE"
    echo 
    echo "To make the choice again, delete this file: ~/intel/openvino_telemetry"
else 
    read -r -p "Do you want to opt out from OpenVINO™ telemetry? [y/N] " response
    case "$response" in
        [yY][eE][sS]|[yY]) 
            opt_in_out --opt_out
            ;;
        *)
            opt_in_out --opt_in
            ;;
    esac
fi

python ./app.py