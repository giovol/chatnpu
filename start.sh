echo "Welcome to ChatNPU!"

# Setup OpenVINO env
echo "Setting up OpenVINO venv..."
python3 -m venv .venv > /dev/null
source .venv/bin/activate > /dev/null
python -m pip install --upgrade pip > /dev/null
pip install openvino > /dev/null

read -r -p "Do you want to opt out from OpenVINO™ telemetry? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        opt_in_out --opt_out
        ;;
    *)
        opt_in_out --opt_in
        ;;
esac
