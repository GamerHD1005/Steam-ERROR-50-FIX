@echo off
chcp 65001 > nul
:: Überprüfung auf Admin-Rechte
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo BITTE ALS ADMINISTRATOR AUSFÜHREN!
    echo Rechtsklick auf die Datei -> "Als Administrator ausführen".
    pause
    exit /b
)

:menu
cls
echo ===================================================
echo   SYSTEM-BEREINIGUNG UND REPARATUR-MENÜ
echo ===================================================
echo.
echo  [2] Steam Error 50 Fix (Beendet Steam + Cache-Reset+Temp + DNS + Neustart)
echo  [4] Steam No-React Shortcut auf Desktop erstellen
echo  [3] Beenden
echo.
echo ===================================================
set /p auswahl="Bitte eine Option wählen (2-4): "

if "%auswahl%"=="2" goto steam_fix
if "%auswahl%"=="4" goto create_shortcut
if "%auswahl%"=="3" exit
goto menu

:steam_fix
cls
echo ===================================================
echo   System-Bereinigung und Steam-Fix gestartet...
echo ===================================================
echo.

:: 1. Steam-Prozesse beenden
echo [1/6] Beende Steam-Prozesse...
taskkill /f /im steam.exe >nul 2>&1
taskkill /f /im steamwebhelper.exe >nul 2>&1
timeout /t 2 >nul

:: 2. Windows Temp-Ordner leeren
echo [2/6] Lösche Windows Temp-Dateien...
del /q /f /s "C:\Windows\Temp\*" 2>nul
for /d %%x in ("C:\Windows\Temp\*") do rd /s /q "%%x" 2>nul

:: 3. Benutzer %temp%-Ordner leeren
echo [3/6] Lösche Benutzer Temp-Dateien...
del /q /f /s "%temp%\*" 2>nul
for /d %%x in ("%temp%\*") do rd /s /q "%%x" 2>nul

:: 4. Steam Error 50 Cache-Reset
echo [4/6] Lösche Steam-HTTP- und Paket-Caches...
if exist "C:\Program Files (x86)\Steam\appcache" rd /s /q "C:\Program Files (x86)\Steam\appcache" 2>nul
if exist "C:\Program Files (x86)\Steam\depotcache" rd /s /q "C:\Program Files (x86)\Steam\depotcache" 2>nul
if exist "C:\Program Files (x86)\Steam\config\htmlcache" rd /s /q "C:\Program Files (x86)\Steam\config\htmlcache" 2>nul

:: 5. DNS-Cache leeren
echo [5/6] Leere DNS-Cache (ipconfig /flushdns)...
ipconfig /flushdns >nul

:: 6. Netzwerk-Stack zurücksetzen
echo [6/6] Setze Winsock-Netzwerkprotokoll zurück...
netsh winsock reset >nul

echo.
echo ===================================================
echo   ALLES ERFOLGREICH ERLEDIGT!
echo   Der PC wird in 10 Sekunden automatisch neu gestartet.
echo   Speichere jetzt deine offenen Dokumente!
echo ===================================================
echo.

timeout /t 10
shutdown /r /t 0
exit


:create_shortcut
cls
echo ===================================================
echo   Erstelle Steam Shortcut auf dem Desktop...
echo ===================================================
echo.

:: Pfad zum Desktop des aktuellen Benutzers ermitteln
set "DESKTOP_PATH=%USERPROFILE%\Desktop"

:: Temporäres VBScript erstellen, um die Verknüpfung zu generieren
set "VBS_SCRIPT=%temp%\CreateSteamShortcut.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") > "%VBS_SCRIPT%"
echo sLinkFile = "%DESKTOP_PATH%\Steam (No-React-Login).lnk" >> "%VBS_SCRIPT%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%VBS_SCRIPT%"
echo oLink.TargetPath = "C:\Program Files (x86)\Steam\steam.exe" >> "%VBS_SCRIPT%"
echo oLink.Arguments = "-login -no-react-login" >> "%VBS_SCRIPT%"
echo oLink.WorkingDirectory = "C:\Program Files (x86)\Steam" >> "%VBS_SCRIPT%"
echo oLink.Description = "Steam mit No-React-Login starten" >> "%VBS_SCRIPT%"
echo oLink.IconLocation = "C:\Program Files (x86)\Steam\steam.exe, 0" >> "%VBS_SCRIPT%"
echo oLink.Save >> "%VBS_SCRIPT%"

:: VBScript ausführen und danach löschen
cscript //nologo "%VBS_SCRIPT%"
del "%VBS_SCRIPT%"

echo [INFO] Die Verknüpfung "Steam (No-React-Login)" wurde auf deinem Desktop erstellt!
echo.
pause
goto menu