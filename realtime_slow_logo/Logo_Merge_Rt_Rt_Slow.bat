:: You need to give the slowed video as input

:: fastFactor =  1 / (speedfactor)
:: For example - 0.25 makes the videos 4x fast-- so converts from 100fps to 25fps(near realtime), 
set fastFactor=0.25


:: Compression quality: 1 (max quality , large size) to 5+(min qual, low size), 
set qualityFactor=1


::Logo Params
:: (xlogo,ylogo) - Position of logo from top left corner 
set "logoRT=logoRT.jpg"
set "logoSlow=logoxSlow.jpg"
set xlogo=0
set ylogo=0


::Make Realtime video
ffmpeg -i "snake100fps.avi" -i %logoRT% -filter_complex "[0:v]setpts=%fastFactor%*PTS[tempRT];[tempRT][1:v]overlay=%xlogo%:%ylogo%[v]" -map "[v]" -vcodec libxvid -q:v %qualityFactor% -an "tempoutput/realTimeWithLogo.avi" 

::Make slowed video
ffmpeg -i "snake100fps.avi" -i %logoSlow% -filter_complex "[0:v][1:v]overlay=%xlogo%:%ylogo%[v]" -map "[v]" -vcodec libxvid -q:v %qualityFactor% -an "tempoutput/slowWithLogo.avi" 

::Make combined video
ffmpeg -i "tempoutput/realTimeWithLogo.avi" -i "tempoutput/realTimeWithLogo.avi" -i "tempoutput/slowWithLogo.avi" -filter_complex "concat=n=3:v=1[v]" -map "[v]" -vcodec libxvid -q:v %qualityFactor% -an "Merged_RTRTSlow.avi" 