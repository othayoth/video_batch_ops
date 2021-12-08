:: Instructions for use:
:: 1. Place this file (concatenate_within_folder.bat) in the root of the directory tree 
:: 2. What this will do is that it will recursively go through the directory tree and generate a text file ('list_to_concat.txt') in each directory containing the list of videos in that directory.
:: 3. FFMPEG commands can then be used to read this list and concatenate videos in each directory level into one video -- it will be save as "directory_concat.avi" in the parent directory.
:: 4. Run concatenate_within_folder.bat from command line (you can double click and run, but opening CMD and running the BAT is recommended for troubleshooting issues)

@echo off & setlocal

:: Compression factor (larger number gives smaller file size but reduced quality)
set "compress_factor=4";

:: /r --> recursively search for all subdirectories in the directory where the BAT file is placed
FOR /r %%i in (.)  DO (	
    :: go to a subdirectory
    cd "%%~fni" 
    :: delete any existing list -- note -- you can copy paste this in line XX to delete the text file after the videos are concatenated
    del "list_to_concat.txt"       
    
    :: search for all avi files in the current subdirectory
    for %%f in (*.avi) do (
        :: add the name of the avi file to the text file
        echo file %%f >>  "list_to_concat.txt"             
    )
    
    :: read through the videos in the text file and then compress and concatenate them into a single video
    ffmpeg -f concat -safe 0 -i "list_to_concat.txt" -c copy -vcodec libxvid -q:v %compress_factor% -an -y "%%~fni/%%~ni_concat.avi"    
    
    echo "done"
)
