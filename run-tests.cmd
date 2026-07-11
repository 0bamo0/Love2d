@echo off
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0run-tests.ps1"
exit /b %ERRORLEVEL%
