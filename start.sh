#!/bin/sh

echo "Welcome to ChatNPU!"

# Ask if the user wants to setup OpenVINO venv
VENV=./.venv
setupvenv()
{
    echo "Setting up OpenVINO™ venv..."
    python3 -m venv .venv
    source .venv/bin/activate
    python -m pip install --upgrade pip
    pip install --upgrade openvino==2025.2.0
    pip install --upgrade flask
    pip install --upgrade "optimum[openvino]"
}

if [ -f "$VENV" ]; then
    read ".venv directory already exists. Do you want to update .venv? [y/N] " response1
    case "$response1" in
        [yY][eE][sS]|[yY]) 
            setupvenv
            ;;
        *)
            ;;
    esac
else
    setupvenv
fi

# Check if telemetry file exists and, if not, ask the user to make a choice
TELEMETRYFILE=~/intel/openvino_telemetry
if [ -f "$TELEMETRYFILE" ]; then
    echo -n "OpenVINO™ telemetry is set to " && cat "$TELEMETRYFILE"
    echo 
    echo "To make the choice again, delete this file: ~/intel/openvino_telemetry"
else 
    read -r -p "Do you want to opt out from OpenVINO™ telemetry? [y/N] " response2
    case "$response2" in
        [yY][eE][sS]|[yY]) 
            opt_in_out --opt_out
            ;;
        *)
            opt_in_out --opt_in
            ;;
    esac
fi

optimum-cli export openvino --model openai-community/gpt2 --task text-generation-with-past --weight-format int8 neural-chat/INT8

python ./app.py