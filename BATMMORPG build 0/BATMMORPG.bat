:top
    echo off
    setlocal enabledelayedexpansion
    cd "%~dp0"/bin
    mode 101,27
    color 0f
    set space=" "
    set build=0
    title BATMMORPG build !build!
    goto menu

:debug
    cls
    echo.
    set /p debug=Debug: 
        !debug!
        goto debug

:menu
    cls
    echo.
    echo  BATMMORPG build !build!
    echo.
    echo  1. Continue
    echo  2. New
    echo  3. Information
    echo  4. Exit
    choice /c 1234 /n
        if !errorlevel! equ 1 goto continue
        if !errorlevel! equ 2 goto new
        if !errorlevel! equ 3 goto info
        if !errorlevel! equ 4 exit

:info
    cls
    echo.
    echo  BATMMORPG build !build!
    echo.
    echo  Created and programmed by: @ripbarns
    echo.
    echo  Press any key to continue.
    pause > nul
        goto menu

:new
    set x=33
    set y=11

    cls
    goto map

:save
    (
        echo !x!
        echo !y!
    ) > sav.txt

    cls
    goto refresh

:continue
    if not exist "sav.txt" goto error

    < sav.txt (
        set /p x=
        set /p y=
    )

    cls
    goto map

:map
    set temp=0

    for /f "tokens=*" %%a in (map.txt) do (
	    set line_!temp!=%%a
	    set /a temp=!temp! + 1
	    echo [3;2HLoading map...
    )

    cls
    goto refresh

:move
    if !errorlevel! equ 1 set /a y=!y! - 1
    if !errorlevel! equ 2 set /a x=!x! - 1
    if !errorlevel! equ 3 set /a y=!y! + 1
    if !errorlevel! equ 4 set /a x=!x! + 1

:collide
    if "!line_%y%:~%x%,1!" neq !space! (
        rem if "!line%y%:~%x%,1!" equ "INSERT_CHARACTER" call INSERT_FILE_NAME.bat
	    if !errorlevel! equ 1 set /a y=!y! + 1
	    if !errorlevel! equ 2 set /a x=!x! + 1
	    if !errorlevel! equ 3 set /a y=!y! - 1
	    if !errorlevel! equ 4 set /a x=!x! - 1
    )

:refresh
    set /a w=!x! - 32
    set /a z=!x! + 1

    for /l %%a in (0 1 9) do (
        set /a u%%a=!y! - 1 - %%a
        set /a d%%a=!y! + 1 + %%a
    )

    set line_u0=!line_%u0%:~%w%,65!
    set line_u1=!line_%u1%:~%w%,65!
    set line_u2=!line_%u2%:~%w%,65!
    set line_u3=!line_%u3%:~%w%,65!
    set line_u4=!line_%u4%:~%w%,65!
    set line_u5=!line_%u5%:~%w%,65!
    set line_u6=!line_%u6%:~%w%,65!
    set line_u7=!line_%u7%:~%w%,65!
    set line_u8=!line_%u8%:~%w%,65!
    set line_u9=!line_%u9%:~%w%,65!

    set line_d0=!line_%d0%:~%w%,65!
    set line_d1=!line_%d1%:~%w%,65!
    set line_d2=!line_%d2%:~%w%,65!
    set line_d3=!line_%d3%:~%w%,65!
    set line_d4=!line_%d4%:~%w%,65!
    set line_d5=!line_%d5%:~%w%,65!
    set line_d6=!line_%d6%:~%w%,65!
    set line_d7=!line_%d7%:~%w%,65!
    set line_d8=!line_%d8%:~%w%,65!
    set line_d9=!line_%d9%:~%w%,65!

    set line_char=!line_%y%:~%w%,32!@!line_%y%:~%z%,32!

    if !x! lss 1000 set filler_x= 
    if !x! lss 100 set filler_x=  
    if !x! lss 10 set filler_x=   

    if !y! lss 1000 set filler_y= 
    if !y! lss 100 set filler_y=  
    if !y! lss 10 set filler_y=   

:screen
    echo [3;2H##################################################################################################
    echo  # !line_u9! #                            #
    echo  # !line_u8! #                            #
    echo  # !line_u7! #                            #
    echo  # !line_u6! #                            #
    echo  # !line_u5! #                            #
    echo  # !line_u4! #                            #
    echo  # !line_u3! #                            #
    echo  # !line_u2! #                            #
    echo  # !line_u1! #                            #
    echo  # !line_u0! #                            #
    echo  # !line_char! #                            #
    echo  # !line_d0! #                            #
    echo  # !line_d1! #                            #
    echo  # !line_d2! #                            #
    echo  # !line_d3! #                            #
    echo  # !line_d4! #                            #
    echo  # !line_d5! #                            #
    echo  # !line_d6! # "!line_%y%:~%x%,1!"                        #
    echo  # !line_d7! # [M] Save                   #
    echo  # !line_d8! ##############################
    echo  # !line_d9! # (!x!,!y!) !filler_x!!filler_y!               #
    echo  ##################################################################################################
    choice /t 1 /d x /c wasdmx /n
        if !errorlevel! leq 4 goto move
        if !errorlevel! equ 5 goto save
        if !errorlevel! equ 6 goto refresh

:error
    cls
    echo.
    echo  An error has occured.
    echo.
    echo  Press any key to continue.
    pause > nul
        goto top