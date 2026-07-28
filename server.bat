@echo off
title EOS 6D Feed
cd /d "%~dp0"
echo Iniciando servidor...
powershell -ExecutionPolicy Bypass -File "%~dp0server.ps1"
pause
