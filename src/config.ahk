#Requires AutoHotkey v2.0
global configFile := A_ScriptDir "\config.ini"
global posX := 100, posY := 100  ; Valores por defecto
global pararConsumir := false
global myGui := Gui("+AlwaysOnTop +ToolWindow +Border")
global SCRIPT_VERSION := GetGitVer()
global CREDITOS := "DLS Macro`n`nDesarrollado por:`n- Diego Orellana`nPerfil GitHub: dorellanag92"

InitConfig(){
    
    ; Si el archivo de configuración no existe, se crea con valores predeterminados
    if !FileExist(configFile) {
        IniWrite(100, configFile, "Window", "X")
        IniWrite(100, configFile, "Window", "Y")
    }

    ; Leer coordenadas desde el archivo de configuración
    global posX := IniRead(configFile, "Window", "X", 100)
    global posY := IniRead(configFile, "Window", "Y", 100)
}

SaveCoords(){
    WinGetPos(&posX, &posY, , , myGui)
    IniWrite(posX, configFile, "Window", "X")
    IniWrite(posY, configFile, "Window", "Y")
}

CerrarScript(*) {
    SaveCoords()
    ExitApp()
}

GetGitVer() {
    try {
        shell := ComObject("WScript.Shell")  ; Permite ejecutar comandos de terminal
        exec := shell.Exec("git describe --tags --abbrev=0")
        version := exec.StdOut.ReadAll()
        return Trim(version) ? Trim(version) : "Sin versión"
    }
    catch {
        return "Desconocida"  ; Si falla, retorna "Desconocida"
    }
}