# Development Guide

This guide explains how to develop, test, and publish the PokeMMO Kasm workspace image.

## Local Development

### Prerequisites
- Docker installed
- Git installed
- Docker Hub account (for publishing)

### Building Locally

```bash
# Build the image
docker build -t developmentcats/pokemmo-kasm:latest .

# Test the image
docker run -d \
  --name pokemmo-test \
  -p 6901:6901 \
  -v pokemmo-config:/pokemmo/config \
  developmentcats/pokemmo-kasm:latest

# Access at https://localhost:6901
# Default credentials: kasm_user/password
```

### Testing

The image includes automated tests that check:
- Container startup
- Java process running
- ROM downloads
- Permissions
- Error logs

Run tests locally:
```bash
docker build -t pokemmo-test:latest .
./test/run_tests.sh
```

## Publishing

### Manual Publishing

1. Build the image:
```bash
docker build -t developmentcats/pokemmo-kasm:latest .
```

2. Test locally:
```bash
docker run -d --name pokemmo-test -p 6901:6901 developmentcats/pokemmo-kasm:latest
```

3. Push to Docker Hub:
```bash
docker push developmentcats/pokemmo-kasm:latest
```

### Automated Publishing

The repository uses GitHub Actions for automated builds and publishing:

1. Set up secrets in GitHub:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token

2. Create a release:
```bash
git tag v1.0.0
git push origin v1.0.0
```

This will trigger:
1. Image build
2. Automated tests
3. Push to Docker Hub (if tests pass)

## Using with Kasm

1. In Kasm Workspaces:
   - Go to Workspaces → Registry
   - Click "Add Workspace"
   - Enter image details:
     ```
     Name: PokeMMO
     Image: developmentcats/pokemmo-kasm:latest
     Friendly Name: PokeMMO
     Description: PokeMMO Client for Kasm Workspaces
     ```

2. The workspace will be available in your Kasm dashboard

## Troubleshooting

### Common Issues

1. ROM Download Failures:
   - Check network connectivity
   - Verify ROM URLs are accessible
   - Check permissions in /pokemmo/roms

2. Java Issues:
   - Check Java process is running
   - Verify Java version compatibility
   - Check memory allocation

3. Permission Issues:
   - Verify user ID 1000 has proper permissions
   - Check directory ownership
   - Verify file permissions

### Logs

Access container logs:
```bash
docker logs pokemmo-test
```

### Debug Mode

Run container with debug output:
```bash
docker run -d \
  --name pokemmo-debug \
  -p 6901:6901 \
  -e DEBUG=true \
  developmentcats/pokemmo-kasm:latest
``` 