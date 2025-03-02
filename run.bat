@echo off
setlocal

:: กำหนด PATH ของโฟลเดอร์ปัจจุบัน
set BASE_DIR=%~dp0
set ENV_DIR=%BASE_DIR%env

:: เปิดใช้งาน Virtual Environment
call %ENV_DIR%\Scripts\activate

:: รัน Python script โดยใช้ path ไดนามิก
python %BASE_DIR%entry_with_update.py
