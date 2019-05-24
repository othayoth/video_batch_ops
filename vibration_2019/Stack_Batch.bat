
:: Text box params -  shows video filename by default
:: (xtext,ytext) - Position of textbox from top-left corner of video 
:: tbcolor / tbalpha - textbox fill color / transparency value
set xtext=0
set ytext=505
set "textcol=white"
set "tbcolor=black"
set tbalpha=0
set tbfontsize=36

:: Compression factor
set qFactor=3

set "stiffness=0"
set "parentDir=H:\Ratan\K%stiffness%\"
set "targetDir=H:\Ratan\stacked-compressed-annot\K%stiffness%\"

set "parentDir=X:\Ratan\5 - Vibration\20190425\K%stiffness%\

md "%targetDir%"

setlocal EnableDelayedExpansion

for /D %%A in ("%parentDir%Trial-*") do 	(

for /L %%F in ( 0,1,7)  do (
		set "x=%%A"
	
				ffmpeg  -i "!x:~0!\C1_%%FHz_000000.avi"  -i "!x:~0!\C2_%%FHz_000000.avi" -i "!x:~0!\C3_%%FHz_000000.avi" -filter_complex "[0:v]scale=960:540[v1];[1:v]scale=960:540[v2];[2:v]scale=960:540[v3];[v1][v3]hstack[t];[v2]pad=1920:540:0:0[b];[t][b]vstack[vall];[vall]drawtext=fontfile=OpenSans-Regular.ttf:fontcolor="%textcol%":text="K%stiffness%_%%FHz_Trial-!x:~-2!":fontsize=%tbfontsize%:x=%xtext%:y=%ytext%:box=1:boxcolor=%tbcolor%@%tbalpha%:boxborderw=5[v]" -map "[v]" -vcodec libxvid -q:v 2 -y "%targetDir%K%stiffness%_%%FHz_Trial-!x:~-2!.avi"
)
)		
		