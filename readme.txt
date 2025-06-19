

Wsl Setup
	#enable wsl 
	#install ubuntu

	#enable systemd To enable systemd in WSL, you need to first ensure you are running WSL version 0.67.6 or higher. Then, you need to edit the wsl.conf file within your Linux distribution's file system to include [boot] systemd=true. Finally, restart your WSL instance using wsl.exe --shutdown from PowerShell. 


	#install nix
	 curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
	  sh -s -- install  #restart wsl
	 #install home manager
	nix run home-manager/master -- init --switch

	#get flake and have it in ~/git/…

	#sym link flake to config
	ln -s ~/git/Nix-Setup-flake/nix ~/.config/nix  #rebuild flake home-manager switch --flake ~/.config/nix#adan@wsl-ubuntu

	#zsh default shell #Create  a local bin directory mkdir -p ~/.local/bin 
	#Create  a symlink 
	ln -sf ~/.nix-profile/bin/zsh ~/.local/bin/zsh 

	#Add  to /etc/shells echo "$HOME/.local/bin/zsh" | sudo tee -a /etc/shells 

	#Change  shell chsh -s "$HOME/.local/bin/zsh"
