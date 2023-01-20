# Contributing

Patches are welcome via the usual mechanisms (pull requests, email, posting to the project issue tracker etc).

For more details, see the "command-t-development" section in [the documentation](https://github.com/wincent/command-t/blob/main/doc/command-t.txt).

# Releasing

1. Update "command-t-history" section in `doc/command-t.txt`.
2. Edit metadata in `lua/wincent/commandt/version.lua` to reflect new `$VERSION`.
3. Commit using `git commit -p -m "chore: prepare for $VERSION release"`.
4. Create tag with `git tag -s $VERSION -m "$VERSION release"`.
5. Check release readiness with `make check`.
6. Produce ZIP archive with `bin/create-archive`.
7. Upload new release to [vim.org](http://www.vim.org/scripts/script.php?script_id=3025).
8. Push with `git push --follow-tags`.
9. Update [release notes on GitHub](https://github.com/wincent/command-t/releases).
10. Start a new entry under "command-t-history" in `doc/command-t.txt` for subsequent development.

# Reproducing bugs

Sometimes [user bug reports](https://github.com/wincent/command-t/issues) depend on characteristics of their local setup. Reproducing this may require copying configuration and installing dependencies, something I'd rather not do to my own development system. So, here are some notes about setting up Vagrant on macOS to provide a disposable VM on which to try things out in a controlled environment.

## Installing Vagrant and VirtualBox

```bash
brew install vagrant
brew install --cask virtualbox
```

## Creating a Vagrant VM

```bash
vagrant init hashicorp/bionic64 # First time only; creates Vagrantfile.
vagrant up
vagrant ssh
```

### Trouble-shooting Vagrant issues

There are lots of things that can go wrong, so here are a few links:

- ["There was an error while executing `VBoxManage`"](https://stackoverflow.com/a/51356705/2103996).
- ["Vagrant up error while executing ‘VBoxManage’"](https://discuss.hashicorp.com/t/vagrant-up-error-while-executing-vboxmanage/16825).

Which, among other things suggest these possible fixes:

```bash
sudo "/Library/Application Support/VirtualBox/LaunchDaemons/VirtualBoxStartup.sh" restart
vagrant destroy -f
vagrant box remove hashicorp/bionic64
rm ~/Library/VirtualBox
```

For me, removing `~/Library/VirtualBox` did the trick.

## Setting up Neovim on the VM

```bash
sudo apt-get update
sudo apt-get install -y neovim # It's v0.2.2 🤦 — not going to be much help, so...

sudo apt-get install -y cmake gettext libtool libtool-bin pkg-config unzip # instead...
git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

## Installing Command-T and other dependencies manually

Manual install:

```bash
BUNDLE=$HOME/.config/nvim/pack/bundle/start
mkdir -p $BUNDLE
git clone --depth 1 https://github.com/wincent/command-t $BUNDLE/command-t
echo "require('wincent.commandt').setup()" > ~/.config/nvim/init.lua
(cd $BUNDLE/command-t/lua/wincent/commandt/lib && make)

# Also install any other plug-ins that might be needed to reproduce a problem; eg:

git clone --depth 1 https://github.com/jiangmiao/auto-pairs $BUNDLE/auto-pairs
```

## Installing Command-T using Packer

For reproducing reports like [this one](https://github.com/wincent/command-t/issues/393#issuecomment-1229541720).

```bash
BUNDLE=$HOME/.config/nvim/pack/bundle/start
mkdir -p $BUNDLE
git clone --depth 1 https://github.com/wbthomason/packer.nvim $BUNDLE/packer.nvim
```

Then, in `~/.config/nvim/init.lua`:

```
require('packer').startup(function(use)
  use {
    'wincent/command-t',
    run = 'cd lua/wincent/commandt/lib && make',
    setup = function ()
      vim.g.CommandTPreferredImplementation = 'lua'
    end,
    config = function()
      require('wincent.commandt').setup()
    end,
  }
end)
```

and run `:PackerInstall`.

## Cleaning up after testing is done

```bash
exit
vagrant halt
vagrant destroy
```
