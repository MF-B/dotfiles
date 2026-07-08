# MF-B dotfiles

Personal Linux desktop configuration snapshot.

This repo intentionally stores a conservative subset of configuration:

- Hyprland config: `.config/hypr`
- Caelestia user config: `.config/caelestia`
- Foot terminal config: `.config/foot/foot.ini`
- Fish shell entry config and greeting function
- Caelestia coarse location helper: `.local/bin/caelestia-location`

The Caelestia shell source itself is managed separately at:

```sh
~/.config/quickshell/caelestia
```

## Sync from this machine

After changing live files under `~/.config`, refresh this repo with:

```sh
./scripts/sync-from-home.sh
git status
git add .
git commit -m "update desktop config"
```

## Restore/install on another machine

This copies the tracked files into `$HOME` and stores a backup first:

```sh
./scripts/install.sh
```

The install script does not create symlinks. It copies files, which is safer
while the desktop is being actively debugged.

## Secrets

Do not commit API tokens, weather keys, SSH keys, Wi-Fi BSSIDs, or precise
location data. Put tokens in environment variables or untracked local files.

`caelestia-location` stores Wi-Fi fingerprints under
`~/.local/state/caelestia`. They are salted hashes and are not tracked.
