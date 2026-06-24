sudo dnf install git
sudo yum install -y yum-utils shadow-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum install -y packer
sudo dnf install python3-pip -y
pip install --upgrade "aws-parallelcluster==3.13.2"
packer plugins install github.com/hashicorp/amazon
