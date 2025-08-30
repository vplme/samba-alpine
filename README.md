# Samba Alpine Docker Container

A lightweight container image running Samba file server on Alpine Linux.

# Using Docker Run

```bash
docker build -t samba-alpine .
docker run -d \
  -p 445:445 \
  -v $(pwd)/data:/samba-data \
  -e SAMBA_USERNAME=paper \
  -e SAMBA_PASSWORD=your_password \
  samba-alpine
```

# Configuration

## Environment Variables

- `SAMBA_USERNAME`: Username for Samba authentication (default: samba)
- `SAMBA_PASSWORD`: Password for Samba authentication (required)
