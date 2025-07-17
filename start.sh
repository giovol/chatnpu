#!/bin/sh

echo "Welcome to ChatNPU!"

# Function to setup venv
setupvenv() {
    echo "Setting up OpenVINO™ venv..."
    python3 -m venv .venv
    . .venv/bin/activate
    python -m pip install --upgrade pip
    pip install --upgrade openvino==2025.2.0
    pip install --upgrade flask
    pip install --upgrade "optimum[openvino]"
}

# Ask to the user if they want to setup venv
VENV=./.venv
if [ -d "$VENV" ]; then
    read -r -p ".venv directory already exists. Do you want to update .venv? [y/N] " venvchoice
    case "$venvchoice" in
        [yY][eE][sS]|[yY])
            setupvenv
        ;;
        *)
        ;;
    esac
else
    setupvenv
fi

# Ask to the user if they want to disable telemetry
TELEMETRYFILE=~/intel/openvino_telemetry
if [ -f "$TELEMETRYFILE" ]; then
    echo -n "OpenVINO™ telemetry is set to " && cat "$TELEMETRYFILE"
    echo
    echo "To make the choice again, delete this file: ~/intel/openvino_telemetry"
else
    read -r -p "Do you want to opt out from OpenVINO™ telemetry? [y/N] " telemetrychoice
    case "$telemetrychoice" in
        [yY][eE][sS]|[yY])
            opt_in_out --opt_out
        ;;
        *)
            opt_in_out --opt_in
        ;;
    esac
fi

# Ask to the user which model do they want to use, and if the user doesn't know automatically choose Intel/neural-chat-7b-v3-3
# You can find models at https://huggingface.co
MODEL=./neural-chat/
if [ -d "$MODEL" ]; then
    print "Model found! If you want to use another one, please delete the 'neural-chat' directory on the script folder"
else
    read -r -p "Which model do you want to use? If you're unsure leave blank: " model
    if [ -n "$model" ]; then
        :
    else
        model="Intel/neural-chat-7b-v3-3"
    fi
    optimum-cli export openvino --model "$model" --task text-generation-with-past --weight-format int8 neural-chat/INT8
fi

python ./app.py
