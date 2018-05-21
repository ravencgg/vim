@echo off

pushd %cd%
:retry

SET currdir=%cd%

IF EXIST build.bat (
    call %currdir%\build.bat
    goto :finished
) ELSE (

    REM If we aren't at the root directory, go up one and try again
    if "%cd:~3,1%"=="" (
        REM echo %cd% is root
        echo Failed to find build.bat in any parent directory!
        goto :finished
    ) else (
        REM echo %cd% is not root
        cd ..
        goto :retry
    )
)

:finished
SET currdir=
popd

