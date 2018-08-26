@echo off
set platform=%1
@rem doesn't use
set configuration=%2

if "%platform%" == "Win32" (
	@rem OK
) else if "%platform%" == "x64" (
	@rem OK
) else (
	call :showhelp %0
	exit /b 1
)

if "%configuration%" == "Release" (
	@rem OK
) else if "%configuration%" == "Debug" (
	@rem OK
) else (
	call :showhelp %0
	exit /b 1
)

set CPPCHECK_EXE=C:\Program Files\Cppcheck\cppcheck.exe
set CPPCHECK_OUT=cppcheck-%platform%-%configuration%.xml

set CPPCHECK_PLATFORM=
if "%PLATFORM%" == "Win32" (
	set CPPCHECK_PLATFORM=win32W
) else if "%PLATFORM%" == "x64" (
	set CPPCHECK_PLATFORM=win64
) else (
	@echo not supported platform
	exit /b 1
)

if exist "%CPPCHECK_OUT%" (
	del %CPPCHECK_OUT%
)

set ERROR_RESULT=0
if exist "%CPPCHECK_EXE%" (
	"%CPPCHECK_EXE%" --force --enable=all --xml --platform=%CPPCHECK_PLATFORM% %~dp0sakura_core 2> %CPPCHECK_OUT% || set ERROR_RESULT=1
)
exit /b %ERROR_RESULT%


@rem ------------------------------------------------------------------------------
@rem show help
@rem see http://orangeclover.hatenablog.com/entry/20101004/1286120668
@rem ------------------------------------------------------------------------------
:showhelp
@echo off
@echo usage
@echo    %~nx1 platform configuration
@echo.
@echo parameter
@echo    platform      : Win32   or x64
@echo    configuration : Release or Debug
@echo.
@echo example
@echo    %~nx1 Win32 Release
@echo    %~nx1 Win32 Debug
@echo    %~nx1 x64   Release
@echo    %~nx1 x64   Release
exit /b 0
