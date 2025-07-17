
# ChatNPU

Chat with AI locally with a ChatGPT-like interface.

It uses a flask local server so you can use a web interface.

<p align="center"><img width="784" height="492" alt="immagine" src="https://github.com/user-attachments/assets/6e349350-7c00-44c1-b825-2a84f7302571" /></p>

## Features

The main features are:
- Chatting with a LLM
- Exporting chats to a local file

That's it.

## Setting up

### Linux and macOS

#### Requirements

You need to have `python`, `pip` and `git` installed on your system.

Additionally, only on Linux, if you want to use the NPU you need to install `intel-npu-driver`. You can find it on the [Snap Store](https://snapcraft.io/intel-npu-driver), [AUR](https://aur.archlinux.org/packages/intel-npu-driver-bin) or from [official sources](https://github.com/intel/linux-npu-driver/releases/).

#### Running

You can run it using the shell script:

```sh
git clone https://github.com/giovol/chatnpu.git
cd chatnpu
chmod +x ./start.sh
./start.sh
```

Alternatively you can set it up manually:

```sh
git clone https://github.com/giovol/chatnpu.git
cd chatnpu
python -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
pip install --upgrade openvino==2025.2.0
pip install --upgrade flask
pip install --upgrade "optimum[openvino]"
optimum-cli export openvino --model Intel/neural-chat-7b-v3-3 --task text-generation-with-past --weight-format int8 neural-chat/INT8
```

Then open your browser on the logged IP, usually [127.0.0.1:5000](http://127.0.0.1:5000)

### Windows

#### Requirements
You need to have `python`, `pip` and `git` installed on your system.

Additionally, if you want to use the NPU you need to install the NPU driver. Refer to your hardware vendor to get the latest drivers.

> [!NOTE]  
> If you want to use the Intel NPU driver you need to have Windows 11, as Windows 10 doesn't support NPU AI workloads

#### Running

```bash
git clone https://github.com/giovol/chatnpu.git
cd chatnpu
python -m venv .venv
.\.venv\Scripts\activate.bat
python -m pip install --upgrade pip
pip install --upgrade openvino==2025.2.0
pip install --upgrade flask
pip install --upgrade "optimum[openvino]"
optimum-cli export openvino --model Intel/neural-chat-7b-v3-3 --task text-generation-with-past --weight-format int8 neural-chat/INT8
```

Then open your browser on the logged IP, usually [127.0.0.1:5000](http://127.0.0.1:5000)

## FAQ

### What is a NPU? Do I need to have a NPU to run this project?

A NPU is an hardware chip that accelerates AI workloads.

No, you don't need a NPU. I chose this name because I finally gave an use for my Intel Core Ultra NPU, that was chilling at 0% for months.

### It runs slow/bad. How can I resolve this?

By default this project uses the CPU to be widely compatible, which can be slow in some cases. To run AI workloads with hardware acceleration replace "CPU" with "GPU" or "NPU" in this line on `app.py`:

```python
ov_model = OVModelForCausalLM.from_pretrained(model_dir, device="CPU")
```

## License 

This project is licensed under the Apache License 2.0. See [LICENSE](https://github.com/giovol/chatnpu/blob/main/LICENSE)

## Contribute

Contributions are always welcome: if you want to resolve a bug or implement a new feature feel free to fork the project and create a pull request.

If you like this project you can star it. Thanks ⭐!
