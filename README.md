### Tuxedo-Keyboard-Nix

Package for the LED-Backlighting for tuxedo notebooks.

Tested with the tuxedo InfityBook Pro 15 v4.

Installs the [kernel module](https://github.com/tuxedocomputers/tuxedo-keyboard).

#### Usage

Clone this repo, import the module in your `configuration.nix`, and use it.

```nix
    imports = 
    [ 
       /path/where/this/is/cloned/modules/tuxedo-keyboard.nix
    ];

    tuxedo-keyboard.enable = true;
```

##### TODOs

* clean this repo up a bit more

* find a way to allow configurations to the colors and modes
