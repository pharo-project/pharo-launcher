SETLOCAL

REM VERSION cannot be a string in Advanced Installer. Let's use 0.0.0 for bleeding edge versions
SET LAUNCHER_VERSION=%INSTALLER_VERSION:bleedingEdge=0.0.0%

SET ADVINST=C:\Program Files (x86)\Caphyon\Advanced Installer 14.7\bin\x86\
SET PATH=%PATH%;%ADVINST%;
SET ADVINST_PROJECT=pharo-launcher.aip
SET ADVINST_COMMAND_FILE=pharo-launcher.aic

SET PHARO_WIN_DIR="Pharo-win\Pharo"
REM cd% will give you the current working directory (variable)
REM %~dp0 will give you the full path to the batch file's directory (static)
SET OUT_DIR=%~dp0

REM Advanced Installer working directory is the directory where the AIP file stands
COPY icons\pharo-launcher.ico windows\
MKDIR windows\Pharo-win
MOVE Pharo windows\Pharo-win\Pharo

cd windows
REM "%ADVINST%AdvancedInstaller.com" /newproject $ADVINST_PROJECT -lang en -overwrite
"%ADVINST%AdvancedInstaller.com" /execute "%ADVINST_PROJECT%" "%ADVINST_COMMAND_FILE%"
MOVE pharo-launcher.msi ..\pharo-launcher-%VERSION%.msi