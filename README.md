# [Pueue][] [packer.nu][] Package

This adds background tasks to nu using [pueue][].

This package contains the steps (except [pueue][] installation)
described in the [nu-book](https://www.nushell.sh/book/background_task.html#using-nu-with-pueue).

## Config

```nu
{packages: [{
    source: 'jan9103/nushell_pueue' as: 'pueue'
    # source: 'https://codeberg.org/packer.nu/pueue'
    config: {
        daemonize: true  # ensure pueue runs as a daemon
    }
}]}
```

[packer.nu]: https://github.com/jan9103/packer.nu
[pueue]: https://github.com/Nukesor/pueue
