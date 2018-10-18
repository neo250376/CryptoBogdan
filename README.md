# CryptoBogdan - Important note - 20Gb instances at least are needed!!!
Combining both Cryptogone's and Bogdan's miner's

This script simply installs both Cryptogone's and Bogdan's miners, but GPU use is disabled on Bogdan's miner as Cryptogone's is much faster. Only CPU is used on Bogdan's miner as this has in fact been found to be faster than any other CPU only miner.

Simply copy and paste the script into your GCP instance automation box

Access the miners with the following -

sudo tmux attach -t bogdan

sudo tmux attach -t cryptogone

To exit tmux and keep the miner running in the background, press CTRL+B then "d" on it's own. This will return you back to the command line interface prompt and is then safe to exit the VPS console.

If you wish to donate towards my research and testing please feel free to donate ARO to the following address - 65AkkjBs2arwbikYVDh3B57aeehzpVp9Xw69tgewj8y8stx9FjajNhxR5Y3D9vzjYGgPGzuXbf7xSKn1C2i2DxFY
