@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build-android-love.ps1"
exit /b %ERRORLEVEL%
