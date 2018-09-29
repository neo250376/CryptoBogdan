#! /bin/bash

# Install dependencies

sudo apt-get update -y
sudo apt-get install ocl-icd-opencl-dev -y
sudo apt-get install cmake -y
sudo apt-get install gcc -y
sudo apt-get install g++ -y
sudo apt-get install git -y
sudo apt-get install tmux -y
sudo apt-get install nano -y

# Installation of Nvidia Driver v396

sleep 3

sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo apt update
sudo apt install nvidia-396 -y

# Start Nvidia driver and enable nvidia-smi

sudo modprobe nvidia

# Installation of Cuda Toolkit - Silent

cd ~

sleep 3

wget https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_9.2.148_396.37_linux
sudo chmod +x cuda_9.2.148_396.37_linux
sudo bash cuda_9.2.148_396.37_linux --silent --toolkit

# Create sym links to enable Cuda to be recognised by Cryptogone's miner

export PATH=/usr/local/cuda-9.2/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-9.2/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Installation of Cryptogone's miner

sleep 5

sudo apt-get install git
git clone https://bitbucket.org/cryptogone/arionum-gpu-miner.git
cd arionum-gpu-miner

./setup_libs.sh linux 

./setup_submodules.sh 

./gen_prj.sh linux

./make_release_linux.sh

cd rel/v1.5.1-linux

# Creation of miner configuration file

echo '#! /bin/bash

# please change pool address, wallet address and worker ID to yours
# adjust -b & -t value as described in the README and FAQ
worker="OvErLoDe"
pool="http://arionum.rocks"
wallet="65AkkjBs2arwbikYVDh3B57aeehzpVp9Xw69tgewj8y8stx9FjajNhxR5Y3D9vzjYGgPGzuXbf7xSKn1C2i2DxFY"
threads="4"
batches="240"

# set this to false if you do not want miner to auto relaunch after crash
relaunch_miner_on_crash="true"

while :
do
    # -u means use all device, you can also use -d to specify list of devices (ex: -d 0,2,5)
    ./arionum-cuda-miner -u -b "$batches" -t "$threads" -p "$pool" -a "$wallet" -i "$worker"
    
    if [ "$relaunch_miner_on_crash" = "true" ]; then
        echo "miner crashed, relaunching in 5 seconds ..."
        sleep 5
    else
        break
    fi
done' > mine.sh
sudo chmod +x mine.sh
tmux new-session -d -s cryptogone './mine.sh'
cd

# Clone into Bogdan's miner and locally compile

git clone http://github.com/bogdanadnan/ariominer.git
cd ariominer
mkdir build
cd build
cmake ..
make

# Create config file and re-run script if miner crashes

echo '#! /bin/bash

# please change pool address, wallet address and worker ID to yours
# adjust -b & -t value as described in the README and FAQ
worker="OvErLoDe"
pool="http://arionum.rocks"
wallet="65AkkjBs2arwbikYVDh3B57aeehzpVp9Xw69tgewj8y8stx9FjajNhxR5Y3D9vzjYGgPGzuXbf7xSKn1C2i2DxFY"
cpuintensity="100"
gpuintensitycblocks="0"
gpuintensitygblocks="0"


# set this to false if you do not want miner to auto relaunch after crash
relaunch_miner_on_crash="true"

while :
do
    # -u means use all device, you can also use -d to specify list of devices (ex: -d 0,2,5)
    ./ariominer --mode miner --pool "$pool" --wallet "$wallet" --name "$worker" --cpu-intensity "$cpuintensity" --gpu-intensity-cblocks "$gpuintensitycblocks" --gpu-intensity-gblocks "$gpuintensitygblocks"  
    
    if [ "$relaunch_miner_on_crash" = "true" ]; then
        echo "miner crashed, relaunching in 5 seconds ..."
        sleep 5
    else
        break
    fi
done' > mine.sh
sudo chmod +x mine.sh
tmux new-session -d -s bogdan './mine.sh'

