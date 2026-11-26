# docker_frankenphp

Image FrankenPHP (PHP 8.5) avec extensions métier + Composer.

## Prérequis : BuildKit

Le `Dockerfile` utilise `RUN --mount=type=cache,...` pour cacher apt entre les builds
(sans grossir l’image). Ça **exige BuildKit**. Sans ça :

```text
the --mount option requires BuildKit
```

BuildKit est le moteur de build Docker moderne (cache, mounts, parallélisme).
Le plugin CLI associé s’appelle **buildx**.

### Install (CachyOS / Arch)

```bash
sudo pacman -S docker-buildx
```

Vérifier :

```bash
docker buildx version
```

### Install (Debian / Ubuntu)

```bash
sudo apt-get update
sudo apt-get install -y docker-buildx-plugin
```

### Activer BuildKit

Depuis Docker 23+, BuildKit est souvent déjà le défaut. Sinon :

```bash
export DOCKER_BUILDKIT=1
# optionnel mais recommandé
export COMPOSE_DOCKER_CLI_BUILD=1
```

Pour le rendre permanent (zsh) :

```bash
echo 'export DOCKER_BUILDKIT=1' >> ~/.zshrc
```

Ou via daemon (`/etc/docker/daemon.json`) puis restart du service :

```json
{
  "features": {
    "buildkit": true
  }
}
```

```bash
sudo systemctl restart docker
```

## Build

```bash
DOCKER_BUILDKIT=1 docker build -t frankenphp-php85 .
```

Avec buildx explicitement :

```bash
docker buildx build -t frankenphp-php85 --load .
```
