@echo off
setlocal

cd %~dp0

set DOTNET_MULTILEVEL_LOOKUP=0
powershell -File build.ps1 %*
