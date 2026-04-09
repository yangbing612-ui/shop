@echo off
cd /d "%~dp0"

echo ===== 开始发布 shop 项目到 GitHub =====
echo.

REM 遍历每个文件夹和文件，逐个添加、提交、推送
for /d %%i in (*) do (
    if NOT "%%i"==".git" (
        echo [处理中] %%i
        git add "%%i"
        git diff --cached --quiet -- "%%i"
        if errorlevel 1 (
            git commit -m "Add: %%i"
            git push -f origin master
            if errorlevel 1 (
                echo [错误] %%i 推送失败
                goto :end
            )
        ) else (
            echo [无变化] %%i
        )
        timeout /t 1 /nobreak >nul
    )
)

REM 处理根目录文件（排除 .git 和文件夹）
for %%i in (*) do (
    if NOT "%%i"==".git" (
        echo [处理中] %%i
        git add "%%i"
        git diff --cached --quiet -- "%%i"
        if errorlevel 1 (
            git commit -m "Add: %%i"
            git push -f origin master
            if errorlevel 1 (
                echo [错误] %%i 推送失败
                goto :end
            )
        ) else (
            echo [无变化] %%i
        )
        timeout /t 1 /nobreak >nul
    )
)

echo.
echo ===== 发布完成! =====
:end
pause
