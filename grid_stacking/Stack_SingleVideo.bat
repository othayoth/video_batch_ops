
:: Text box params -  shows video filename by default
:: (xtext,ytext) - Position of textbox from top-left corner of video 
:: tbcolor / tbalpha - textbox fill color / transparency value


set xtext=0
set ytext=505
set "textcol=white"
set "tbcolor=black"
set tbalpha=0
set tbfontsize=36





set qFactor=3


set "stiffness=0"


set "parentDir=X:\Ratan\5 - Vibration\20190425\K3\Temp0Hz\"
set "targetDir=X:\Ratan\5 - Vibration\20190425\K3\Temp0Hz\"

set "parentDir=X:\Ratan\5 - Vibration\20190425\K%stiffness%\Trial-03\"

set "trialName=1Hz"


md "%targetDir%"
setlocal EnableDelayedExpansion
echo 1



				ffmpeg  -i "%parentDir%C1_%trialName%_000000.avi"  -i "%parentDir%C2_%trialName%_000000.avi" -i "%parentDir%C3_%trialName%_000000.avi" -filter_complex "[0:v]scale=960:540[v1];[1:v]scale=960:540[v2];[2:v]scale=960:540[v3];[v1][v3]hstack[t];[v2]pad=1920:540:0:0[b];[t][b]vstack[vall];[vall]drawtext=fontfile=OpenSans-Regular.ttf:fontcolor="%textcol%":text="K%stiffness%_%trialName%":fontsize=%tbfontsize%:x=%xtext%:y=%ytext%:box=1:boxcolor=%tbcolor%@%tbalpha%:boxborderw=5[v]" -map "[v]" -vcodec libxvid -q:v 2 -y "%targetDir%K%stiffness%_%trialName%.avi"
