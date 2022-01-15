# Archiving operations

## Merging/concatenating multiple videos in a directory into a single video
1. Place `concatenate_within_folder.bat` at the top of the directory tree
2. Open command line at location where the batch file is placed
3. Run the batch file by typing `concatenate_within_folder.bat` in the command line
4.  See instructions within batch file for more details

## Replicating directory with compressed videos
1. Place `move_compress.bat` at the top of the directory tree
2. Open command line at location where the batch file is placed
3. Run the batch file by typing `move_compress.bat` in the command line
4.  See instructions within batch file for more details


## Line-by-line explanation

### `concatenate_within_folder.bat`
```
@echo off & setlocal
set "compress_factor=4";
FOR /r %%i in (.)  DO (	    
    cd "%%~fni" 
    del "list_to_concat.txt"           
    for %%f in (*.avi) do (
        echo file %%f >>  "list_to_concat.txt"             
    )
    ffmpeg -f concat -safe 0 -i "list_to_concat.txt" -c copy -vcodec libxvid -q:v %compress_factor% -an -y "%%~fni/%%~ni_concat.avi"    
    echo "done"
)
```

1. `@echo off & setlocal` 
- Display options \
  - `@echo off` Turns off the command being displayed in the command line \
  - `setlocal` command is used so that variables defined (see next section) are local in scope. For more explanation, see [Local v/s Global variables](https://www.tutorialspoint.com/batch_script/batch_script_variables.htm)



2. `set "compress_factor=4";`
Here we define and assign a local variable called `compress_factor`.



3. `FOR /r %%i in (.)  DO (	... )` 
- This is a for loop in batch scripting
  - `/r` option is used to iterate through all folders and subfolders
  - `%%i` is the loop variable -- here it is a placeholder for a directory
  - `in (.)` -- specifies to begin searching for all directories iteratively, starting from the directory where batch file is placed
  - `DO (...)` -- carry out the commands within the parentheses



4. `cd "%%~fni"` 
- Change directory to the directory that is being looped over
  - `cd` -- **c**hange **d**irectory
  - `%%~fni` is the path to the directory `i` (which is the loop variable)
  - `%%` is usually placed before a **loop** variable (here `i`, which is the directory name) to invoke the value of the variable
  - `~` -- indicates that it is a path
  - `fni` -- **f**older **n**ame of **i**th folder
  - `~fni

5.  `del "list_to_concat.txt"`
- Searches the current directory for the file `"list_to_concat.txt"` and deletes it (this is necessary as we need to create a new text file with the list of videos to be merged

6. ``` 
    for %%f in (*.avi) do (
        echo file %%f >>  "list_to_concat.txt"             
    )
    ```
- This is a for loop that finds all AVI files in the current directory and adds the line `file NAME_OF_AVI` to the text file `list_to_concat.txt`
  - The syntax of for loop is similar to what is explained above; 
  - `%%f` is the loop variable
  - `(*.avi)` is used to loop over all files with extension .avi
  - `echo` is used to print (this is similar to `fprintf` in C language). 
    
7. `ffmpeg ...`
- This is the main video processing command
  - `ffmpeg` -- call ffmpeg 
  - `-f` -- apply a filter (sometimes `-filter_complex` is also used -- see other batch files)
  - `concat` -- name of the filter (can use multiple filters like `scale`, `textbox` -- see other batch files in the repository) 
  - `-safe 0` -- Not sure what exactly, but likely a fix for unsafe filenames (see [comment in this answer](https://stackoverflow.com/a/11175851))
  - `-i "list_to_concat.txt"` -- `-i` stands for **i**nput; here instead of listing each input video to be concatenated, we specify a text file with list of input videos
  - `-c copy` -- Copy the frames directly without going through decode->filter->encode process (see answer [here](https://stackoverflow.com/a/38381173))
  - `-vcodec libxvid` -- specify the video codec (XVid here). To list all video codecs available, type `ffmpeg -codecs` in command line. More info [here](https://stackoverflow.com/a/20587693)
  - `-q:v %compress_factor%` -- **Q**uality of video compression. To use the value of the `compress_factor` (or any) static variable defined earlier, enclose them in `%`
  - `-an` -- **N**o **a**udio stream in output
  - `-y` -- Overwrites any existing output file with same name.
  - `"%%~fni/%%~ni_concat.avi"` -- `%%~fni` is the path of the current directory. `%%~ni` is the name of the current directory. So if you are in a directory called `D:/videos`, you will see an output video `D:/videos/videos_concat.avi`
