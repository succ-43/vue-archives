@echo off
setlocal enabledelayedexpansion

:: Fetch the current branch name
for /f "tokens=3" %%i in ('git branch --show-current') do set current_branch=%%i

:: Get the list of untracked files
for /f "tokens=*" %%i in ('git status --porcelain') do (
    set line=%%i
    set first_char=!line:~0,2!

    :: Check if the line represents an untracked file
    if "!first_char!" == "??" (
        set filepath=!line:~3!
        echo Adding file: !filepath!
        git add "!filepath!"
        git commit -m "!filepath!"
        git push origin %current_branch%
    )
)

endlocal
