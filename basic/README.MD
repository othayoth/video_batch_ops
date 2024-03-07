## prerequisites

- install ffmpeg by running the command `brew install ffmpeg` from a terminal

## basic video compression

- download/copy [compress_videos.sh](./compress_videos.sh) to your folder
- make it executable by running the command `chmod +x compress_videos.sh` in your terminal
- edit the script:
  - Change the `VIDEO_DIR` variable to the path of your folder containing the videos.
  - Adjust the `CRF` value if you want a different quality. A lower CRF value results in better quality but larger file sizes. The default is set to 23.
- run the script: Execute the script by navigating to its directory and running `./compress_videos.sh` in your terminal.
