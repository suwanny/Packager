# Packager

An easy rails APT package repository.

## Requirement
  ubuntu and ruby on rails
  sudo aptitude install reprepro
  
## Configuration
```yaml
  
auth_key: 8d26a8f6751a3caf7
base_dir: package

distributions:
  - origin: Companay, inc.
    label: Companay, inc.
    codename: natty
    architectures: amd64
    components: main
    description:  Companay Apt Repository
    signwith: false

  - origin: Companay, inc.
    label: Companay, inc.
    codename: trunk
    architectures: amd64
    components: main
    description:  Companay Apt Repository
    signwith: false

options:
  - verbose
  - --ask-passphrase
  
```

## API
  POST http://x.x.x.x/package/upload
  GET http://x.x.x.x/package/list

## How to upload from remote

```bash
curl -F package=@sample_1.0_amd64.deb -F code=stable -F key=yourkey http://x.x.x.x/package/upload

```