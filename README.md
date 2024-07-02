# Memacs

Memacs is a tiny and untraditional GNU Emacs configuration.

## Installing

Clone this git repository into `~/.emacs.d`:
```console
$ git clone https://gitlab.com/Marcu5H/memacs.git ~/.emacs.d
```

Memacs depend on [luamacs](https://github.com/MAlba124/luamacs), download it:
```console
$ git submodule update --remote
```

Build and install it:
```console
$ cd luamacs
```

If you use nix execute `nix develop` before proceeding

```console
$ make build && cd ..
$ ln -s luamacs/emacs emacs
```

If icons are not showing correctly, install the required fonts with `M-x all-the-icons-install-fonts`.

## Configuration

Basic configuration is done by editing the `config` table in `init.lua`.
If any packages/features/languages are missing, open an issue.
