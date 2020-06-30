@echo %off
setlocal enableDelayedExpansion
if exist %~dp0%build rmdir /s /q build
if not exist %~dp0%build md build
cd %~dp0%build
set /p M_YEAR=Maya version (year): 
set VS[0]="Visual Studio 15 2017 Win64"
set VS[1]="Visual Studio 16 2019"
echo Build with either:
echo - [0] for [%VS[0]%]
echo - [1] for [%VS[1]%]
set VS_OPTION=0
set /p "VS_OPTION=Enter build generator: "
set M_GEN=!VS[%VS_OPTION%]!
echo Building with %M_GEN%
cmake ../ -G %M_GEN% -DMAYA_VERSION=%M_YEAR%
cmake --build . --config Debug
endlocal
pause