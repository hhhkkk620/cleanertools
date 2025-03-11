@echo off
chcp 936 >nul
cls

:: 设置窗口标题和颜色
title ?? Windows 系统清理工具 ??
color 0A

:: 显示主菜单
:MENU
cls
echo =====================================================
echo   ██████╗ ██╗     ██╗███╗   ██╗███████╗███████╗
echo   ██╔══██╗██║     ██║████╗  ██║██╔════╝██╔════╝
echo   ██████╔╝██║     ██║██╔██╗ ██║███████╗█████╗
echo   ██╔═══╝ ██║     ██║██║╚██╗██║╚════██║██╔══╝
echo   ██║     ███████╗██║██║ ╚████║███████║███████╗
echo   ╚═╝     ╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝
echo =====================================================
echo    Windows 清理工具 !!  fakerman修改定制  原作者：https://github.com/ossamamehmood/Junk_Files_Cleaner/releases/tag/Junk_File_Cleaner
echo =====================================================
echo  1. 清理系统临时文件                                                                                                       
echo  2 .清理用户临时文件                                                                                                       
echo  3 .清理 Windows 更新缓存                                                                                            
echo  4 .清理 Internet 缓存浏览记录                                                                                  
echo  5 .清理回收站                                                                                                                  
echo  6 . 一键深度清理（推荐）
echo  0 .退出                                                                                                                             
echo tips:无需担心误删系统重要文件!!  比原批处理更加强大更加便捷!!
echo =====================================================
set /p choice= 请输入你的选择（0-6）：

:: 选择清理选项
if "%choice%"=="1" call :CLEAN_FILES "%windir%\Temp"
if "%choice%"=="2" call :CLEAN_FILES "%temp%"
if "%choice%"=="3" call :CLEAN_WIN_UPDATE
if "%choice%"=="4" call :CLEAN_BROWSER_CACHE
if "%choice%"=="5" call :CLEAN_RECYCLE_BIN
if "%choice%"=="6" call :CLEAN_ALL
if "%choice%"=="0" exit
goto MENU

:: 清理文件夹内所有文件
:CLEAN_FILES
call :LOADING
call :PROGRESS
echo 正在清理：%1...
if exist "%1" (
    del /s /f /q "%1\*.*" 2>nul
)
call :PRINT_DONE
goto MENU

:: 清理 Windows 更新缓存
:CLEAN_WIN_UPDATE
call :LOADING
call :PROGRESS
echo 正在清理 Windows 更新缓存...
net stop wuauserv >nul 2>&1
if exist "%windir%\SoftwareDistribution\Download" (
    rd /s /q "%windir%\SoftwareDistribution\Download" 2>nul
    md "%windir%\SoftwareDistribution\Download"
)
net start wuauserv >nul 2>&1
call :PRINT_DONE
goto MENU

:: 清理浏览器缓存
:CLEAN_BROWSER_CACHE
call :LOADING
call :PROGRESS
echo 正在清理 Internet 缓存...
for %%d in (
    "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files"
    "%userprofile%\AppData\Local\Microsoft\Windows\History"
    "%userprofile%\AppData\Local\Microsoft\Windows\Cookies"
) do (
    if exist "%%d" rd /s /q "%%d" 2>nul
)
call :PRINT_DONE
goto MENU

:: 清理回收站
:CLEAN_RECYCLE_BIN
call :LOADING
call :PROGRESS
echo 正在清理回收站...
rd /s /q C:\$Recycle.Bin D:\$Recycle.Bin 2>nul
call :PRINT_DONE
goto MENU

:: 一键深度清理
:CLEAN_ALL
call :LOADING
call :PROGRESS
echo 正在进行深度清理...

:: 清理所有临时文件
call :CLEAN_FILES "%windir%\Temp"
call :CLEAN_FILES "%temp%"

:: 清理 Windows 更新缓存
call :CLEAN_WIN_UPDATE

:: 清理 Internet 缓存
call :CLEAN_BROWSER_CACHE

:: 清理回收站
call :CLEAN_RECYCLE_BIN

call :PRINT_DONE
goto MENU

:: 清理完成动画
:PRINT_DONE
echo ? 清理完成！
timeout /t 2 >nul
goto MENU

:: 旋转加载动画
:LOADING
setlocal enabledelayedexpansion
set "chars=| / - \"
for /L %%i in (1,1,5) do (
    for %%c in (!chars!) do (
        echo  清理中... %%c
        timeout /t 0.2 >nul
        cls
    )
)
exit /b

:: 进度条动画
:PROGRESS
setlocal enabledelayedexpansion
set "progress="
for /L %%i in (1,1,20) do (
    set "progress=!progress!#"
    echo  清理中... !progress! (%%i0%%)
    timeout /t 0.1 >nul
    cls
)
exit /b
