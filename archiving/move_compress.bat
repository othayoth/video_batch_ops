:: Instructions for use:
:: 1. Place this file (move_compress.bat) in the root of the directory tree that needs to be replicated and compressed
:: 2. Run move_compress.bat from command line (you can double click and run, but opening CMD and running the BAT is recommended for troubleshooting issues)
:: 3. Suppose this bat file is placed in "D:/TestVid", the directory tree inside "D:/TestVid" will be replicated in the folder "D:/compressed_vid" (the destination can be changed as needed by modyfying line 29)
 

@echo off & setlocal

:: Compression factor (larger number gives smaller file size but reduced quality)
set "compress_factor=4";

:: Position of text from upper left corner
set "xtext=0"     
set "ytext=0"
:: Color of text
set "textcol=green"
:: Color and alpha of text box
set "tbcolor=black"
set "tbalpha=.5"
:: Fontsize
set "tbfontsize=12"

:: /r --> recursively search for all avi files in the directory where the BAT file is placed
FOR /r %%i in (*.avi) DO (

	:: replicate the Directory structure
	:: %%~di --> Drive letter of the current video file
	:: \compressed_vid	--> Copies the current directory tree to into a folder called "compressed_vid"
	mkdir "%%~di\compressed_vid%%~pi"
	
:: compression code	
ffmpeg -i "%%~fi" -vf drawtext=fontfile=C\\:/Windows/fonts/consola.ttf:fontcolor="%textcol%":text="%%~ni":fontsize=%tbfontsize%:x=%xtext%:y=%ytext%:box=1:boxcolor=%tbcolor%@%tbalpha%:boxborderw=5 -vcodec libxvid -q:v %compress_factor% -an -y "%%~di\compressed_vid\%%~pni.avi"
)

