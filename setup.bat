@echo off
setlocal

:: กำหนด PATH ของโฟลเดอร์ปัจจุบัน
set BASE_DIR=%~dp0
set ENV_DIR=%BASE_DIR%env

pip install virtualenv

:: ตรวจสอบว่ามี Python อยู่ในระบบหรือไม่
where python > nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] ไม่พบ Python ในระบบ กรุณาติดตั้ง Python ก่อน
    pause
    exit /b
)

:: ตรวจสอบว่า Virtual Environment มีอยู่หรือไม่ ถ้าไม่มีให้สร้าง
if not exist "%ENV_DIR%" (
    echo Creating virtual environment...
    python -m venv %ENV_DIR%
)

:: ตรวจสอบว่า Python ใน `env` ถูกสร้างขึ้นหรือไม่
if not exist "%ENV_DIR%\Scripts\python.exe" (
    echo [ERROR] Python ใน Virtual Environment ไม่ถูกต้อง ลองตรวจสอบการติดตั้งอีกครั้ง
    pause
    exit /b
)

:: ใช้ Python จาก `env` โดยตรง
echo Activating Virtual Environment...
call "%ENV_DIR%\Scripts\activate"

:: อัปเกรด pip
"%ENV_DIR%\Scripts\python.exe" -m pip install --upgrade pip

:: ติดตั้ง dependencies
"%ENV_DIR%\Scripts\python.exe" -m pip install -r "%BASE_DIR%requirements_versions.txt"

:: ลบ torch และ torchvision ก่อนติดตั้งใหม่
"%ENV_DIR%\Scripts\python.exe" -m pip uninstall torch torchvision -y

:: ติดตั้ง torch, torchvision, torchaudio ตาม CUDA version
"%ENV_DIR%\Scripts\python.exe" -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

echo Installation complete!
pause
