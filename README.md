# PokeMMO for Kasm Workspaces

This repository contains a Dockerfile for running PokeMMO in a Kasm Workspace container. The image is based on the official Kasm Ubuntu Jammy image and includes everything needed to run PokeMMO in a browser-accessible workspace.

## Features

- Based on Kasm Workspaces Ubuntu Jammy image
- Includes Java Runtime Environment for PokeMMO
- Desktop shortcut for easy access
- Persistent configuration through Docker volumes
- Optimized for browser-based access
- Automatic ROM downloading for educational purposes
- Pre-configured with all necessary game files

## Usage with Kasm Workspaces

1. In your Kasm Workspaces installation, go to Workspaces > Registry
2. Click "Add Workspace"
3. Enter the following details:
   - Name: PokeMMO
   - Description: PokeMMO Client for Kasm Workspaces
   - Image: developmentcats/pokemmo-kasm:latest
   - Friendly Name: PokeMMO

4. Click "Add Workspace"

The workspace will now be available to launch from your Kasm dashboard.

## ROM Support

This image includes automatic downloading of the following ROMs for educational purposes:
- Pokemon Black (NDS)
- Pokemon Emerald (GBA)
- Pokemon FireRed (GBA)
- Pokemon Platinum (NDS)

ROMs are automatically downloaded to `/pokemmo/roms/` if they don't exist.

## Building Locally

To build the image locally:

```bash
docker build -t developmentcats/pokemmo-kasm:latest .
```

## Environment Variables

- `TITLE`: Window title (default: PokeMMO-Docker)
- `REVISION`: PokeMMO revision number
- `XDG_SESSION_TYPE`: Session type (default: x11)

## Volumes

- `/pokemmo/config`: Persistent storage for PokeMMO configuration and saves
- `/pokemmo/roms`: Storage for game ROMs (automatically populated)
- `/pokemmo/data/mods`: Storage for game modifications

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Original PokeMMO game by the PokeMMO team
- Kasm Workspaces for the base container image
- ROM files are used for educational purposes only 