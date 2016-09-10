install:
	mkdir -p ~/.config
	# nvim
	ln -f -s `pwd`/nvim ~/.config/nvim
	# vifm
	ln -f -s `pwd`/vifm ~/.config/vifm
	# xmonad
	ln -f -s `pwd`/xmonad ~/.xmonad
	# xmobar
	ln -f -s `pwd`/xmobarrc ~/.xmobarrc
	# terminator
	ln -f -s `pwd`/terminator ~/.config/terminator

install_package_query:
	mkdir -p build
	rm -rf build/package-query-git
	cd build; curl -L "https://aur.archlinux.org/cgit/aur.git/snapshot/package-query-git.tar.gz" > package-query-git.tar.gz
	cd build; tar -xvf package-query-git.tar.gz
	cd build/package-query-git; makepkg -s
	sudo pacman -U build/package-query-git/*.pkg*

install_yaourt: install_package_query
	mkdir -p build
	rm -rf build/yaourt-git
	cd build; curl -L "https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt-git.tar.gz" > yaourt-git.tar.gz
	cd build; tar -xvf yaourt-git.tar.gz
	cd build/yaourt-git; makepkg -s
	sudo pacman -U build/yaourt-git/*.pkg*

install_packages: install
	yaourt --needed -S - < pkglist.txt

update_pkglist:
	yaourt -Qq > pkglist.txt
