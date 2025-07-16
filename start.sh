echo "Welcome to ChatNPU!"

# Clone the repository of open model zoo, and if already exists update it
DIR=./open_model_zoo
if [ -d "$DIR" ];
then
    echo "$DIR already exists. Pulling the latest version..."
    cd ./open_model_zoo
    git pull
    cd ..
else
	echo "$DIR directory does not exist. Cloning the repository..."
    git clone https://github.com/openvinotoolkit/open_model_zoo.git
fi

# Setup OpenVINO env
python3 -m venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install openvino-dev

read -r -p "Do you want to opt out from OpenVINO™ telemetry? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        opt_in_out --opt_out
        ;;
    *)
        opt_in_out --opt_in
        ;;
esac
