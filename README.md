# Docker recipe for Development in Go

The `build.sh` script will generate a new image based on the phusion/baseimage.
It will populate the root users home folder with the profile from github.com/johnweldon/tiny-profile.
Also, it will copy your `.local.bashrc` file and your `.ssh/config`, `.ssh/id_rsa`, and `.ssh/id_rsa.pub` to the root profile.
