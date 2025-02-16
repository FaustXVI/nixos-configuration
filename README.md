# Nixos configuration


## How to use

Make sure a file representing the machine you want to setup is present in the `machines` folder and follwed by git.

Create a usb stick with :

```
nix run .#create-install-usb /dev/sdXX
```

Start the machine you want to install and run the script `install-script-XXX` and follow the setup

