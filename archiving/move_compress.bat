@echo off & setlocal
set "compress_factor=6";
set SUBDIR=%~p0


FOR /r %%i in (*.avi) DO (
	ECHO "%%~di%SUBDIR:~0,-1%_compressed%%~pi%%~xi"
	mkdir "%%~di%SUBDIR:~0,-1%_compressed%%~pi"
	ffmpeg -i "%%~fi" -vcodec libxvid -q:v %compress_factor% -an -y "%%~di%SUBDIR:~0,-1%_compressed%%~pni.avi"
)

::FOR /r %%i in (*.mp4) DO (
::	ECHO "%%~di%SUBDIR:~0,-1%_compressed%%~pi%%~xi"
::	mkdir "%%~di%SUBDIR:~0,-1%_compressed%%~pi"
::	ffmpeg -i "%%~fi" -vcodec libxvid -q:v %compress_factor%  "%%~di%SUBDIR:~0,-1%_compressed%%~pni.avi"
::)

