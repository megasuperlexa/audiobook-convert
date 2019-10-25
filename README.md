# Audiobook Convert — Manjaro-friendly
A shell script to convert mp3 to m4b files, album cover supported.

## Dependencies
`audiobook-convert` uses `ffmpeg` and `rename`. For ffmpeg, make sure you have access to `libfdk_aac`.
```shell
sudo pikaur -Syu pod2man
sudo pikaur -Syu ffmpeg-libfdk_aac
```

## Instructions
1. Clone the repo.

```shell
git clone https://github.com/megasuperlexa/audiobook-convert
```

2. Running the script.

Move all `.mp3` files to be combined and converted into `input/`, add a cover (optional) - any .png file, and from the root folder of the repository, run:
```shell 
sudo chmod +x convert.sh 
./convert.sh
```

## How do I load my book to iPhone?

I used to dual-boot to Windows and deal with iTunes and iBooks, which was not a pleasant experience, and sometimes, for unknown reasons, iBooks just won't play my book properly. Here's 100% Linux-friendly way (which doesnt require iTunes and wires at all):

1. Send the m4b file to yourself via Telegram messenger (Saved Messages)
2. On the device, install BookPlayer from AppStore. This is the nicest audiobook player I've seen, completely free and opensource: https://github.com/TortugaPower/BookPlayer
3. On the device, from Telegram, copy the book to the BookPlayer (via select-more-share-more-copy to BookPlayer). Enjoy!
