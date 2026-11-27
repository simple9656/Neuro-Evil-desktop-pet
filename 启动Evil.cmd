@echo off
set "NEURO_SHIMEJI_LAUNCHER=%~dp0Start-Original-Shimeji.ps1"
powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -Command "& $env:NEURO_SHIMEJI_LAUNCHER -Mascot Evil"
set "NEURO_SHIMEJI_LAUNCHER="
