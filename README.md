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

