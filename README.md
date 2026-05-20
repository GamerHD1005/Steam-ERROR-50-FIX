# Steam Error 50 Fix

Ein automatisiertes Windows-Batch-Skript, das den hartnäckigen **Steam Error 50** behebt, temporären Systemmüll beseitigt und Netzwerkverbindungen zurücksetzt. Zusätzlich bietet es die Möglichkeit, eine spezielle Desktop-Verknüpfung zu erstellen, um Login-Probleme zu umgehen.

## 🛠️ Features

Das Tool bietet ein interaktives Menü mit folgenden Funktionen:

* **[Option 2] Steam Error 50 Fix:**
  * Beendet alle aktiven Steam- und Webhelper-Prozesse radikal.
  * Löscht die Windows- und Benutzer-Temp-Ordner (`%temp%`), um blockierte Daten freizugeben.
  * Bereinigt spezifische Steam-Caches (`appcache`, `depotcache`, `htmlcache`), die für den Fehler 50 verantwortlich sind.
  * Leert den DNS-Cache (`flushdns`) und setzt den Winsock-Netzwerkstack zurück.
  * Startet den PC nach 10 Sekunden automatisch neu, damit alle Änderungen greifen.
* **[Option 4] Steam No-React Shortcut:**
  * Erstellt automatisch eine modifizierte Verknüpfung auf deinem Desktop.
  * Startet Steam mit den Parametern `-login -no-react-login`, was bei eingefrorenen oder schwarzen Login-Fenstern hilft.

---

## 🚀 Installation & Verwendung

### Voraussetzungen
* **Windows 10 oder 11**
* **Administratorrechte** (das Skript prüft dies beim Start automatisch ab, da Netzwerk- und Systemordner modifiziert werden).

### Schritt-für-Schritt-Anleitung
1. Lade dir die `Fix.bat` (oder wie du die Datei genannt hast) herunter.
2. Mache einen **Rechtsklick** auf die Datei und wähle **"Als Administrator ausführen"**.
3. Wähle im Menü die gewünschte Option aus:
   * Drücke `2` für den kompletten Steam-Fix (Achtung: PC startet danach neu!).
   * Drücke `4` für die Desktop-Verknüpfung.

---

## 🔍 Ein Blick in den Code (Funktionsweise)

Das Skript arbeitet transparent und sicher. Hier sind die Kernbefehle, die im Hintergrund ausgeführt werden:

### Steam- & Cache-Bereinigung
```cmd
taskkill /f /im steam.exe
taskkill /f /im steamwebhelper.exe

rd /s /q "C:\Program Files (x86)\Steam\appcache"
rd /s /q "C:\Program Files (x86)\Steam\depotcache"
rd /s /q "C:\Program Files (x86)\Steam\config\htmlcache"
