# home-manager

Instructions:

<details>
    <summary>Step 1: Install Nix</summary>

```sh
sh <(curl -L https://nixos.org/nix/install)
```

Select all defaults.

----

</details>


<details>
    <summary>Step 1: Install Home Manager</summary>

```sh
nix run home-manager/master -- init --switch
```

This will create your `~/.config/home-manager`, you can delete it and checkout
the content of this repo.

----

</details>

- Note: do not install nix-darwin
- Checkout this folder in `~/.config/home-manager`.
- Run `home-manager switch`
- Run `nix-channel --update && home-manager switch` to update `home-manager`.


# Manual

## Fixing Nix After OSX Update

OSX update can nuke mounts.

```sh
/usr/sbin/diskutil list | grep Nix
   7:                APFS Volume Nix Store               6.0 GB     disk3s7
```

The last bit, `disk3s7` is the "disk identifier".

```sh
/usr/sbin/diskutil info disk3s7
```

Gives us the Volume UUID. Which has to be used in `/etc/fstab`:

```sh
cat /etc/fstab
#
# Warning - this file should only be modified with vifs(8)
#
# Failure to do so is unsupported and may be destructive.
#

# nix-installer created volume labelled `Nix Store`
UUID=75DA38CE-DEAD-486E-9A3D-1F61DBFAB14D /nix apfs rw,noauto,nobrowse,suid,owners
```

Also ensure:

```sh
cat /etc/synthetic.conf
run private/var/run
nix
```

And reboot.

Then locate the volume in Disk Utility, and mount it. Looks like we have to do
this on every reboot.

## `z`

Use `z <pattern>` to cd into folders ("zip around"). `zi <pattern>` to run
interactive search for pattern. Or `z <pattern><SPACE><TAB>` to run interactive
search.

## `f`

If you make a minor command error, running `f` can figure out a fixed command.

## `hm` & `hmu`

After modifying `home-manager` files, run `hm` from anywhere to apply changes.

Run `hmu` to update everything.

## Mac Utils

https://saurabhs.org/advanced-macos-commands

## Tig Shortcuts

Use tig!

https://jonas.github.io/tig/doc/manual.html

## Nix Garbage Collection

`nix-collect-garbage -d`

## Nix Info

```sh
nix-shell -p nix-info --run "nix-info -m"
 - system: `"aarch64-darwin"`
 - host os: `Darwin 22.4.0, macOS 13.3`
 - multi-user?: `yes`
 - sandbox: `no`
 - version: `nix-env (Nix) 2.11.0`
 - channels(amitu): `""`
 - channels(root): `"nixpkgs"`
 - nixpkgs: `/nix/var/nix/profiles/per-user/root/channels/nixpkgs`
```

## Passing User Data

Currently user data is hard coded in home.nix, meaning others can not use this
setup. Have to figure out how to pass data to imports.

https://github.com/the-nix-way/nome/blob/main/home-manager/default.nix
https://github.com/thexyno/nixos-config/blob/main/flake.nix
https://xyno.space/post/nix-darwin-introduction
https://gist.github.com/jmatsushita/5c50ef14b4b96cb24ae5268dab613050


## More Mac Settings

Looks like a lot of mac settings can be configured using nix: https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236.
Have not yet tried them.
