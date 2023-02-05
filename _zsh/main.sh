# change default shell to zsh
chsh -s /bin/zsh
# may need to write "exec zsh" to ~/.profile

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/$USER/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew upgrade

# iterm2
brew install --cask iterm2

# oh my zsh
rm -rf /Users/$USER/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
sed -i '' 's/plugins=(git.*/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc

# power level 10k
cd ~
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
sed -i '' 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc

# git autocomplete
mkdir ~/.zsh
cd ~/.zsh
curl -o _git https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh
curl -o git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash

# Load Git completion
echo '' >> ~/.zshrc
echo '# Load Git completion' >> ~/.zshrc
echo "zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash" >> ~/.zshrc
echo 'fpath=(~/.zsh $fpath)' >> ~/.zshrc
echo 'autoload -Uz compinit && compinit' >> ~/.zshrc

echo 'manually run source ~/.zshrc'
# y n n 1 2 1 2 1 1 1 n 1 y
