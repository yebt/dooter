mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
echo "export PATH=~/.npm-global/bin:\$PATH" > ~/.profile
fish -c "fish_add_path -g ~/.npm-global/bin"  
source ~/.profile
npm install -g jshint
npm install -g npm@latest

