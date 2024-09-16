echo "Installing stow"
apt install stow

echo "Installing git"
apt install git

echo "Installing unzip"
apt install unzip

echo "Installing build-essential procps file"
apt install build-essential procps file -y

echo "Installing webi"
curl -sS https://webi.sh/webi | sh

echo "Installing bun"
webi bun

echo "Installing brew"
webi brew

echo "Installing zsh"
apt install zsh -y

echo "Installing oh-my-posh"
brew install jandedobbeleer/oh-my-posh/oh-my-posh