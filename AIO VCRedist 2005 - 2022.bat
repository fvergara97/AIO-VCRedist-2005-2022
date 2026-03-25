@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
CD /d %~dp0

:: Verificar si se ejecuta como administrador
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo  =============================================
    echo   Ups.. Debes ejecutarlo como administrador
    echo  =============================================
    echo.
    pause >nul
    exit /b 1
)

echo.    
echo  █████╗ ██╗ ██████╗     ██╗   ██╗ ██████╗██████╗ ███████╗██████╗ ██╗███████╗████████╗
echo ██╔══██╗██║██╔═══██╗    ██║   ██║██╔════╝██╔══██╗██╔════╝██╔══██╗██║██╔════╝╚══██╔══╝
echo ███████║██║██║   ██║    ██║   ██║██║     ██████╔╝█████╗  ██║  ██║██║███████╗   ██║   
echo ██╔══██║██║██║   ██║     ██╗ ██╔╝██║     ██╔══██╗██╔══╝  ██║  ██║██║╚════██║   ██║   
echo ██║  ██║██║╚██████╔╝      ████╔╝ ╚██████╗██║  ██║███████╗██████╔╝██║███████║   ██║   
echo ╚═╝  ╚═╝╚═╝ ╚═════╝        ╚═══╝   ╚═════╝╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝╚══════╝   ╚═╝ 

echo.
echo          Microsoft Visual C++ All-In-One Runtimes 
echo                by. Fernando A. Munoz Vergara
echo		                  v. 1.0
echo.
set TMPLOG=%TEMP%\vcredist_log.txt
del "%TMPLOG%" 2>nul
:: Detectar arquitectura
set IS_X64=0
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set IS_X64=1
if "%PROCESSOR_ARCHITEW6432%"=="AMD64" set IS_X64=1
:: Instalaciones
call :INSTALL "2005 x86" "vcredist2005_x86.exe /q"
if "%IS_X64%"=="1" call :INSTALL "2005 x64" "vcredist2005_x64.exe /q"
call :INSTALL "2008 x86" "vcredist2008_x86.exe /qb"
if "%IS_X64%"=="1" call :INSTALL "2008 x64" "vcredist2008_x64.exe /qb"
call :INSTALL "2010 x86" "vcredist2010_x86.exe /passive /norestart"
if "%IS_X64%"=="1" call :INSTALL "2010 x64" "vcredist2010_x64.exe /passive /norestart"
call :INSTALL "2012 x86" "vcredist2012_x86.exe /passive /norestart"
if "%IS_X64%"=="1" call :INSTALL "2012 x64" "vcredist2012_x64.exe /passive /norestart"
call :INSTALL "2013 x86" "vcredist2013_x86.exe /passive /norestart"
if "%IS_X64%"=="1" call :INSTALL "2013 x64" "vcredist2013_x64.exe /passive /norestart"
call :INSTALL "2015-2022 x86" "vcredist2015_2017_2019_2022_x86.exe /passive /norestart"
if "%IS_X64%"=="1" call :INSTALL "2015-2022 x64" "vcredist2015_2017_2019_2022_x64.exe /passive /norestart"
goto END
:INSTALL
echo Instalando %~1...
start /wait %~2
set ERR=%errorlevel%
if %ERR%==0 (
    echo   [OK] instalado correctamente.
    echo [OK] %~1 instalado correctamente.>> "%TMPLOG%"
) else if %ERR%==1638 (
    echo   [INFO] ya estaba instalado.
    echo [INFO] %~1 ya estaba instalado.>> "%TMPLOG%"
) else if %ERR%==3010 (
    echo   [OK] instalado ^(requiere reinicio^).
    echo [OK] %~1 instalado ^(requiere reinicio^).>> "%TMPLOG%"
) else (
    echo   [ERROR] fallo con codigo %ERR%.
    echo [ERROR] %~1 fallo con codigo %ERR%.>> "%TMPLOG%"
)
exit /b
:END
echo.
echo =====================================
echo           RESUMEN FINAL
echo =====================================
echo.
if exist "%TMPLOG%" (
    type "%TMPLOG%"
    del "%TMPLOG%"
)
echo.
echo Presione ENTER para salir...
pause >nul