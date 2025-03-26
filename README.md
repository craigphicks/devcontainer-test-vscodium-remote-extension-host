# Evaluating devcontainer-cli Without VS Code

This experiment evaluates the feasibility of using `devcontainer-cli` with VSCodium as an alternative to VS Code for devcontainer development. The goal was to assess whether this combination could provide a more open-source friendly development environment while maintaining devcontainer functionality.

## Overview

The setup includes a minimal configuration with VSCodium server as the backend, representing the basic requirements for devcontainer operation. This allows testing of core functionalities without additional extensions or features.

## Prerequisites

- Node.js
- `@devcontainers/cli` npm package
- Docker

## Repository Structure

```bash
.
├── .devcontainer
│   ├── devcontainer.json    # Container configuration
│   ├── Dockerfile          # Container image definition
│   └── init-vscodium-server.sh  # Server initialization script
├── devcontainer-up.sh      # Container startup script
```

## Key Findings

### What Works
- Container successfully starts and runs
- Environment variables and configuration parameters are correctly passed
- VSCodium server initializes properly

### Limitations

1. **Port Forwarding**
   - The `forwardPorts` configuration in `devcontainer.json` is not honored by `devcontainer up`:
   ```json
   "forwardPorts": [11111]
   ```
   - Manual port forwarding through Docker may be required as a workaround

2. **Automatic Extension Installation**
   - The `devcontainer` command automatically installs numerous VS Code extensions without user consent
   - Notable pre-installed extensions include:
     - Multiple VS Code debug extensions
     - Git integration tools
     - Language features for JavaScript, TypeScript, HTML, CSS
     - Authentication modules for Microsoft and GitHub
   - These extensions are installed regardless of whether they're needed or compatible with VSCodium

3. **Documentation Gaps**
   - Most devcontainer documentation assumes VS Code usage
   - Manual extension installation procedures differ from VS Code (examples available in the [devcontainers/cli repository](https://github.com/devcontainers/cli/tree/main/example-usage))

## Technical Implications

1. **Backend Dependencies**
   - While the frontend could use VSCodium, the backend remains dependent on Microsoft extensions
   - Some pre-installed extensions may be proprietary and incompatible with VSCodium

2. **Alternative Considerations**
   - For projects not requiring devcontainers, consider using open-source alternatives
   - docker.io provides an open-source Docker implementation with full port forwarding capabilities

## Conclusion

The approach of using devcontainer-cli with VSCodium presents significant limitations:

1. Missing core functionality (e.g., port forwarding)
2. Forced installation of potentially incompatible VS Code extensions
3. Continued reliance on proprietary components in the backend

For projects requiring devcontainer compatibility, this setup could potentially work with additional development. However, for projects prioritizing open-source solutions, alternative containerization approaches using pure docker.io might be more appropriate.

## Future Considerations

For those interested in pursuing this approach:
- Development of custom port forwarding solutions
- Creation of VSCodium-specific extension management
- Documentation improvements for non-VS Code implementations

