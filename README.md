# Audiobook Convert - Manjaro-friendly
A shell script to convert mp3 to m4b files.

## Dependencies
`audiobook-convert` uses `ffmpeg` and `rename`. For ffmpeg, make sure you have access to `libfdk_aac`.
```shell
sudo pikaur -Syu ffmpeg-libfdk_aac
```

## Instructions
1. Clone the repo.

```shell
git clone https://github.com/megasuperlexa/audiobook-convert
```

2. Running the script.

Move all `.mp3` files to be combined and converted into `input/` and from the root folder of the repository, run:

` sh convert.sh`
