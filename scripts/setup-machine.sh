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

echo "Installing aliasman"
webi aliasman

echo "Installing LS Deluxe"
webi lsd

echo "Installing ripgrep"
webi ripgrep

echo "Installing bat"
webi bat



echo "Installing fzf"
brew install fzf


echo "Setting Aliases"

aliasman ga 'git add'
aliasman gc 'git commit -m'
aliasman gri 'git rebase -i'
aliasman la 'lsd -AF'
aliasman ll 'lsd -lAhF'
aliasman ls 'lsd -F'
aliasman rgi 'rg -i'
aliasman tree 'lsd -F --tree --group-dirs=last'