#!/bin/sh

echo "Welcome to ChatNPU!"

# Setup OpenVINO venv
echo "Setting up OpenVINO™ venv..."
python3 -m venv .venv > /dev/null
source .venv/bin/activate > /dev/null
python -m pip install --upgrade pip > /dev/null
pip install openvino > /dev/null
pip install flask > /dev/null

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