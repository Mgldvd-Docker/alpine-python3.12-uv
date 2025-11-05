<!-- markdownlint-disable first-line-heading -->
<p align="center">
  <a href="https://hub.docker.com/r/mgldvd/alpine-python3.12-uv" target="_blank"><img src="https://raw.githubusercontent.com/Mgldvd-Docker/alpine-php85/refs/heads/master/.github/assets/mgldvd-docker-banner.png" alt="Mgldvd-Docker" height="auto" /></a>
</p>

# Alpine Python 3.12 + uv Docker Image

<p float="left">
  <img src="https://cdn.svgporn.com/logos/docker.svg" height="40" title="docker">
  <img src="https://www.svgrepo.com/show/304556/three-dots.svg" height="30" title="dots">
  <img src="https://cdn.svglogos.dev/logos/python.svg" height="40" title="python">
</p>

**Docker + Python 3.12 + uv**

This repo builds the `mgldvd/alpine-python3.12-uv` Docker image on top of `python:3.12-alpine`, adding Bash tooling and uv.

- **GitHub**: https://github.com/Mgldvd-Docker/alpine-python3.12-uv
- **Docker Hub**: https://hub.docker.com/r/mgldvd/alpine-python3.12-uv

## 🧭 Overview

Single Dockerfile using Alpine and Python 3.12 with uv preinstalled, published by the GitHub Actions workflow on `deploy/hub`.

### 📦 Packages installed via `apk add`

- `bash`
- `sudo`
- `curl`
- `ca-certificates`
- `neovim`
- `coreutils`

### 🔧 Added tooling

- uv installed via the official installer and linked at `/usr/local/bin/uv`
- Non-root user `master` with passwordless sudo
- Bash profile with a custom prompt, `ll` helper, and `vim` alias to `nvim`
- Working directory `/app` owned by `master`

## 🏷️ Image Tags

| Tag | Description |
| --- | --- |
| `latest` | Most recent successful build on `deploy/hub` |

## ☁️ Docker Hub

### 🚀 Quick start

```sh
docker run --rm -it -v "$PWD:/app" mgldvd/alpine-python3.12-uv
```

### 🧪 Python requests example

Inside the container:

```sh
uv init requests-demo

cd requests-demo

uv add requests
```

```sh
cat <<'PY' > main.py
import requests


def main() -> None:
  response = requests.get("https://httpbin.org/json", timeout=5)
  print(response.json()["slideshow"]["title"])


if __name__ == "__main__":
  main()
PY
```

```sh
uv run main.py
```

## 🏗️ Building Locally

Clone the project and build the image using the provided Dockerfile:

```sh
git clone https://github.com/Mgldvd-Docker/alpine-python3.12-uv.git

cd alpine-python3.12-uv

docker build -t mgldvd/alpine-python3.12-uv:local .
```

Run the container to verify the build:

```sh
docker run --rm -it -v "$PWD:/app" mgldvd/alpine-python3.12-uv:local
```

## 📤 Publishing Workflow

The GitHub Actions workflow at `.github/workflows/docker-publish.yml` automates image publication. It performs the following steps:

1. Checks out the repository.
2. Prepares Docker Buildx for multi-platform builds.
3. Authenticates against Docker Hub using repository secrets.
4. Generates OCI metadata, including links back to GitHub and Docker Hub.
5. Builds the image and pushes the multi-arch `latest` tag.

### 🔐 Required Secrets

Add the following secrets in the GitHub repository settings before running the workflow:

- `DOCKERHUB_USERNAME`: Docker Hub account name (for example `mgldvd`).
- `DOCKERHUB_TOKEN`: Docker Hub access token with permission to push the repository.

### ▶️ Triggering a Publish

Push commits to the `deploy/hub` branch or run the workflow manually from the GitHub Actions tab to build and publish a new image version.

## 🤝 Contributing

Issues and pull requests are welcome. Please open a discussion in the GitHub repository if you plan substantial changes so proposals can be coordinated with the publishing workflow.
