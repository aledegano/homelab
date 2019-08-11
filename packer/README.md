# Packer for Raspberry Pie images

Download `https://github.com/solo-io/packer-builder-arm-image/releases/download/v0.1.0/packer-builder-arm-image`
and place the binary where the PATH can see it.
Install packer.
From this directory run packer: `packer build iso-raspberry.json`.
The output image is saved in `output-arm-image`.
Use balena etcher to flash the image on a sd card.