# ubuntu systems
sudo apt update -y
sudo apt upgrade -y
sudo apt-get update -y

# prereqs
sudo apt install git wget curl unzip snapd -y
sudo apt-get install jq xclip -y

# install Terraform v1.1.8
TER_VER=1.1.8
wget https://releases.hashicorp.com/terraform/${TER_VER}/terraform_${TER_VER}_linux_amd64.zip
unzip terraform_${TER_VER}_linux_amd64.zip
rm terraform_${TER_VER}_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# install awscli v2
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
rm -rf aws
rm awscliv2.zip

# install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# install helm3
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# .bashrc
cp .bashrc ~/.bashrc

# install chrome; uninstall firefox
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
sudo apt-get purge firefox

# install p3x-onenote
sudo snap install p3x-onenote

# install waterloo vpn
xdg-open https://uwaterloo.ca/mechanical-mechatronics-engineering-information-technology/virtual-private-network-vpn#install-ubuntu-vpn
