@echo off

set UnrealPak=F:\UnrealEditors\UE_4.27\Engine\Binaries\Win64\UnrealPak.exe
set sModName=%1
set sModManagerModsFolder=C:\Users\Thomas\AppData\Local\IcarusModManager\Mods\

if [%1]==[] goto :usage

if not exist "%~dp0\%sModName%" goto :error

echo F:\UnrealProjects\Icarus\Saved\Cooked\WindowsNoEditor\Icarus\Content\Mods\%sModName%\*.* ../../../Icarus/Content/Mods/%sModName%/*.* > "%~dp0\%sModName%\response.txt"

%UnrealPak% "%~dp0\%sModName%\ModContent\%sModName%_P.pak" -Create="%~dp0\%sModName%\response.txt"

:createzip

del "%sModName%.zip"
"D:\Program Files\7-Zip\7z.exe" a "%sModName%".zip "%~dp0\%sModName%\ModContent\*"
echo f | xcopy /s /y "%sModName%".zip "%sModManagerModsFolder%""%sModName%".zip

:installmods

"D:\Game Modding\Icarus\IcarusModManager-Crystal~Sara-Local\IcarusModManager\bin\x64\Debug\net6.0-windows\IcarusModManager.exe" --install

if %ERRORLEVEL% NEQ 0 goto :install_error

@echo:
@echo Mods installed

goto :eof

:error
@echo Mod not found: %1
exit /B 1

:install_error
@echo Mods failed to install
exit /B 1

:usage
@echo Usage: %0 ^<ModFolderToBuild^>
exit /B 1