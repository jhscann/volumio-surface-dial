# Publishing

Repository: https://github.com/jhscann/volumio-surface-dial

## Development install from GitHub
```sh
cd /home/volumio
git clone https://github.com/jhscann/volumio-surface-dial.git
cd volumio-surface-dial
volumio plugin install
volumio vrestart
```

## Volumio packaging
On a Volumio development device, from the plugin directory:
```sh
volumio plugin install
volumio plugin package
```

Normal end-user distribution should ultimately be through the Volumio plugin store rather than manual SSH installation.

## Release gate
Do not describe v0.1.0 as stable until `docs/TESTING.md` passes on a current Volumio 4 image and at least one real Microsoft Surface Dial. Once validated, create an annotated Git tag and GitHub release.
