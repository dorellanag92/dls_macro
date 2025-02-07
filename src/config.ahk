#Requires AutoHotkey v2.0
global configFile := A_ScriptDir "\config.ini"
global posX := 100, posY := 100  ; Valores por defecto
global pararConsumir := false
global myGui := Gui("+AlwaysOnTop +ToolWindow +Border")
global updGui := Gui()
global SCRIPT_VERSION := "v0.4.0"
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
    global version
    try {
        shell := ComObject("WScript.Shell")  ; Permite ejecutar comandos de terminal
        exec := shell.Exec("git describe --tags --abbrev=0")
        version := Trim(exec.StdOut.ReadAll(),"`r`n ")
        return version ? version : "Sin versión"
    }
    catch Error as err {
        MsgBox("Error al obtener version actual", "Error")
        return "Desconocida"  ; Si falla, retorna "Desconocida"
    }
}

VerificarUltimaVersion() {
    Sleep(1000)
    try {
        GetGitVer()
        global downloadURL, version
        downloadURL := "https://github.com/dorellanag92/dls_macro/releases/latest"
        if (SCRIPT_VERSION != version) {
            MostrarActualizacionDisponible(downloadURL, version)
        } else {
            ;MsgBox("Tienes la última versión: " SCRIPT_VERSION, "Versión Actualizada")
        }
    } catch Error as e {
        MsgBox("Ha ocurrido un error al intentar obtener la version actual", "Error")
    }
}