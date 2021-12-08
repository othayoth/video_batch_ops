for %%f in (*.avi) do (
    echo file %%f >> list.txt
)
ffmpeg -f concat -safe 0 -i list.txt -c copy output.avi
del list.txt
