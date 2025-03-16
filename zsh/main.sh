# change default shell to zsh
chsh -s /bin/zsh
# may need to write "exec zsh" to ~/.profile

SCRIPT_DIR=$(dirname "$0")
cd ~

# oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

# zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
awk '{gsub(/^plugins=\(git.*/, "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)")}1' ~/.zshrc > ~/.zshrc.tmp && mv ~/.zshrc.tmp ~/.zshrc

# power level 10k
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
awk '{gsub(/ZSH_THEME="robbyrussell"/, "ZSH_THEME=\"powerlevel10k/powerlevel10k\""); print}' ~/.zshrc > ~/.zshrc.tmp && mv ~/.zshrc.tmp ~/.zshrc
cp "$SCRIPT_DIR/.p10k.zsh" ~/.p10k.zsh

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
