# ZSH CONFIG

## .zshrc

Add the following to .zshrc to source the contents of this folder

```sh
    for FILE in ~/.config/zshrc/*.sh; do
        source $FILE
    done
```
