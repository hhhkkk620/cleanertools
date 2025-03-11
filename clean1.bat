@echo off
chcp 936 >nul
cls

:: ���ô��ڱ������ɫ
title ?? Windows ϵͳ������ ??
color 0A

:: ��ʾ���˵�
:MENU
cls
echo =====================================================
echo   �������������[ �����[     �����[�������[   �����[���������������[���������������[
echo   �����X�T�T�����[�����U     �����U���������[  �����U�����X�T�T�T�T�a�����X�T�T�T�T�a
echo   �������������X�a�����U     �����U�����X�����[ �����U���������������[�����������[
echo   �����X�T�T�T�a �����U     �����U�����U�^�����[�����U�^�T�T�T�T�����U�����X�T�T�a
echo   �����U     ���������������[�����U�����U �^���������U���������������U���������������[
echo   �^�T�a     �^�T�T�T�T�T�T�a�^�T�a�^�T�a  �^�T�T�T�a�^�T�T�T�T�T�T�a�^�T�T�T�T�T�T�a
echo =====================================================
echo    Windows ������ !!  fakerman�޸Ķ���  ԭ���ߣ�https://github.com/ossamamehmood/Junk_Files_Cleaner/releases/tag/Junk_File_Cleaner
echo =====================================================
echo  1. ����ϵͳ��ʱ�ļ�                                                                                                       
echo  2 .�����û���ʱ�ļ�                                                                                                       
echo  3 .���� Windows ���»���                                                                                            
echo  4 .���� Internet ���������¼                                                                                  
echo  5 .�������վ                                                                                                                  
echo  6 . һ����������Ƽ���
echo  0 .�˳�                                                                                                                             
echo tips:���赣����ɾϵͳ��Ҫ�ļ�!!  ��ԭ���������ǿ����ӱ��!!
echo =====================================================
set /p choice= ���������ѡ��0-6����

:: ѡ������ѡ��
if "%choice%"=="1" call :CLEAN_FILES "%windir%\Temp"
if "%choice%"=="2" call :CLEAN_FILES "%temp%"
if "%choice%"=="3" call :CLEAN_WIN_UPDATE
if "%choice%"=="4" call :CLEAN_BROWSER_CACHE
if "%choice%"=="5" call :CLEAN_RECYCLE_BIN
if "%choice%"=="6" call :CLEAN_ALL
if "%choice%"=="0" exit
goto MENU

:: �����ļ����������ļ�
:CLEAN_FILES
call :LOADING
call :PROGRESS
echo ��������%1...
if exist "%1" (
    del /s /f /q "%1\*.*" 2>nul
)
call :PRINT_DONE
goto MENU

:: ���� Windows ���»���
:CLEAN_WIN_UPDATE
call :LOADING
call :PROGRESS
echo �������� Windows ���»���...
net stop wuauserv >nul 2>&1
if exist "%windir%\SoftwareDistribution\Download" (
    rd /s /q "%windir%\SoftwareDistribution\Download" 2>nul
    md "%windir%\SoftwareDistribution\Download"
)
net start wuauserv >nul 2>&1
call :PRINT_DONE
goto MENU

:: �������������
:CLEAN_BROWSER_CACHE
call :LOADING
call :PROGRESS
echo �������� Internet ����...
for %%d in (
    "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files"
    "%userprofile%\AppData\Local\Microsoft\Windows\History"
    "%userprofile%\AppData\Local\Microsoft\Windows\Cookies"
) do (
    if exist "%%d" rd /s /q "%%d" 2>nul
)
call :PRINT_DONE
goto MENU

:: �������վ
:CLEAN_RECYCLE_BIN
call :LOADING
call :PROGRESS
echo �����������վ...
rd /s /q C:\$Recycle.Bin D:\$Recycle.Bin 2>nul
call :PRINT_DONE
goto MENU

:: һ���������
:CLEAN_ALL
call :LOADING
call :PROGRESS
echo ���ڽ����������...

:: ����������ʱ�ļ�
call :CLEAN_FILES "%windir%\Temp"
call :CLEAN_FILES "%temp%"

:: ���� Windows ���»���
call :CLEAN_WIN_UPDATE

:: ���� Internet ����
call :CLEAN_BROWSER_CACHE

:: �������վ
call :CLEAN_RECYCLE_BIN

call :PRINT_DONE
goto MENU

:: ������ɶ���
:PRINT_DONE
echo ? ������ɣ�
timeout /t 2 >nul
goto MENU

:: ��ת���ض���
:LOADING
setlocal enabledelayedexpansion
set "chars=| / - \"
for /L %%i in (1,1,5) do (
    for %%c in (!chars!) do (
        echo  ������... %%c
        timeout /t 0.2 >nul
        cls
    )
)
exit /b

:: ����������
:PROGRESS
setlocal enabledelayedexpansion
set "progress="
for /L %%i in (1,1,20) do (
    set "progress=!progress!#"
    echo  ������... !progress! (%%i0%%)
    timeout /t 0.1 >nul
    cls
)
exit /b
