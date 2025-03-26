# Experiment using devcontainer-cli without vscode 

This was an experiment to see how working without VSCode, but with  with the npm `devcontainers-cli` package would be useful or convenient.  

If that were convenient, then it might be possible to use VSCodium + devcontainer-cli as a replacement for VSCodium, and still be able to use and share devcontainers.

The Dockerfile loads the vscodium server so that the vscodium would be able to communicate with the server backend.  No other features or extension were included - this is just the basic minimum that would be required before going any further.

## Prequisites

- `node` 
- the npm packge `devcontainers-cli`


The directory structure in this repo looks like:

```
.
├── .devcontainer
│   ├── devcontainer.json
│   ├── Dockerfile
│   └── init-vscodium-server.sh
├── devcontainer-up.sh
```

## Results


The container does successfully start.  The variables and names are successfully interpreted and passed along.

However, the port forwarding section in `.devcontainer/devcontainer.json` is not iomplemented by the `devcontainer up` call.
```
	"forwardPorts": [11111]
```


In addition, `devcontainer` command automatically (without being asked) adds all these extensions to the container:

```
codiserv@ce97d97b1911:~$ .vscodium-server/bin/codium-server --list-extensions
ms-vscode.js-debug
ms-vscode.js-debug-companion
ms-vscode.vscode-js-profile-table
vscode.configuration-editing
vscode.css-language-features
vscode.debug-auto-launch
vscode.debug-server-ready
vscode.emmet
vscode.extension-editing
vscode.git
vscode.git-base
vscode.github
vscode.github-authentication
vscode.grunt
vscode.gulp
vscode.html-language-features
vscode.ipynb
vscode.jake
vscode.json-language-features
vscode.markdown-language-features
vscode.markdown-math
vscode.media-preview
vscode.merge-conflict
vscode.microsoft-authentication
vscode.npm
vscode.php-language-features
vscode.references-view
vscode.search-result
vscode.simple-browser
vscode.terminal-suggest
vscode.tunnel-forwarding
vscode.typescript-language-features
```
I checked that installing and running the vscodium server (a.k.a. vscodium remote extension host) alone does not install any extensions.  Whether all those unasked for extensions are "extreme convenience" or "bloat and inflated attack surface" depends on your requirements.  Some of those extensions might be unusable in vscodium.

Extensions will also have to be installed manually. You can find examples how to do that in https://github.com/devcontainers/cli/tree/main/example-usage.  Note that said repository is expected to be used with vscode.

It also notable that the most documentation about devcontainers carries the implicit assumption that vscode is being used.

## Conclusion 

No.

