# CryptoBogdan
Combining both Cryptogone's and Bogdan's miner's

This script simply installs both Cryptogone's and Bogdan's miners, but GPU use is disabled on Bogdan's miner as Cryptogone's is much faster. Only CPU is used on Bogdan's miner as this has in fact been found to be faster than any other CPU only miner.

Simply copy and paste the script into your GCP instance automation box

Access the miners with the following -

sudo tmux attach -t bogdan
sudo tmux attach -t cryptogone
