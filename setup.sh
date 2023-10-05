#!/usr/bin/env /bin/bash

echo "creating venv"
mkdir venv && python3 -m venv venv/ || echo "venv already exists"
mkdir -p serve/model_store

source venv/bin/activate
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
pip3 install torchserve torch-model-archiver torch-workflow-archiver transformers Pillow torchdata
cd serve/

# linux
#wget -c https://github.com/pytorch/serve/releases/download/v0.8.2/linux-64-torchserve-0.8.2-py310_0.tar.bz2 -O -  | tar -xj
# mac
wget -c https://github.com/pytorch/serve/releases/download/v0.8.2/osx-64-torchserve-0.8.2-py39_0.tar.bz2 -O -  | tar -xj

echo "inference_address=http://0.0.0.0:8080
management_address=http://0.0.0.0:8081
service_envelope=body
default_workers_per_model=2" > ./config

echo "source ../venv/bin/activate
torchserve --foreground --start --ts-config config --ncs --model-store model_store --models all" > ./run.sh

chmod +x ./run.sh
