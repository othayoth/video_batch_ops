:: Instructions for use:
:: 1. Place this file (move_compress.bat) in the root of the directory tree that needs to be replicated and compressed
:: 2. Run move_compress.bat from command line (you can double click and run, but opening CMD and running the BAT is recommended for troubleshooting issues)
:: 3. Suppose this bat file is placed in "D:/TestVid", the directory tree inside "D:/TestVid" will be replicated in the folder "D:/compressed_vid" (the destination can be changed as needed by modyfying line 29)
 

@echo off & setlocal

:: Compression factor (larger number gives smaller file size but reduced quality)
set "compress_factor=4";

:: Root directory
set "ROOT_DIR=D:\TestVidMove\original\"

:: /r --> recursively search for all avi files in the directory where the BAT file is placed
FOR /r %%i in (.)  DO (	
    cd "%%~fni" 
    del "list_to_concat.txt"       
    for %%f in (*.avi) do (
        echo file %%f >>  "list_to_concat.txt"             
    )
    ffmpeg -f concat -safe 0 -i "list_to_concat.txt" -c copy -vcodec libxvid -q:v %compress_factor% -an -y "%%~fni/%%~ni_concat.avi"    
    echo "YASS"
)
