# home-manager

Instructions:

<details>
    <summary>Step 1: Install Nix</summary>

```sh
sh <(curl -L https://nixos.org/nix/install)
```

Select all defaults.
</details>


<details>
    <summary>Step 1: Install Home Manager</summary>

```sh
nix run home-manager/master -- init --switch
```

This will create your `~/.config/home-manager`, you can delete it and checkout
the content of this repo.
</details>

- Checkout this folder in `~/.config/home-manager`.
- Run `home-manager switch`



