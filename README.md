# Running the image to develop

1. Make sure to have build the docker image:
```bash
sudo docker build -t cpp-dev-suite .
```

2. Run the image interactively and build, providing your current username
```bash
sudo docker run -it --mount type=bind,src=$(pwd),dst=/app --rm cpp-dev-suite
```
- `-it` runs interactive terminal from the base `ubuntu` image
- `--mount ...` binds your files in the local source directory into the container destination directory and any changes made there get saved locally
    - now means you need to add the user to the root group to edit them since they're made within a container
- `--rm` automatically removes a container once it is dead