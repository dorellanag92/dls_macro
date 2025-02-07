#Requires AutoHotkey v2.0
#Include C:\Users\kille\Desktop\DLS\dls_macro\src\config.ahk 

CrearGUI() {
    ;myGui := Gui("+AlwaysOnTop +ToolWindow +Border")
    myGui.SetFont("s11", "Arial")
    myGui.Title := ("DLS Macro " SCRIPT_VERSION)
    myGui.Add("Text", "Center", "[Asignación de Teclas]")
    myGui.Add("Text", "Center", "F1 → Matar Zombies")
    ;myGui.Add("Text", "Center", "F2 → Obtener Posición del Puntero")
    myGui.Add("Text", "Center", "F2 → Consumir Stamina")
    myGui.Add("Text", "Center", "F3 → Recolectar Recursos")
    myGui.Add("Text", "Center", "R  → Recargar")
    myGui.Add("Text", "Center", "E  → Cerrar")
    myGui.Add("Text", "Center w300 vEstado", "Esperando comando...")
    myGui.Add("Button", "Center w80", "Acerca de").OnEvent("Click", MostrarAcercaDe)
}

MostrarAcercaDe(*) {
    acercaGui := Gui("+Owner" myGui.Hwnd)  ; Hacer que la ventana principal sea su dueña
    acercaGui.Title := "Acerca de"
    acercaGui.SetFont("s10", "Arial")
    acercaGui.Add("Text", "Center w300", "Versión: " SCRIPT_VERSION)
    acercaGui.Add("Text", "Center w300", CREDITOS)
    acercaGui.Add("Button", "Center w100", "OK").OnEvent("Click", (*) => acercaGui.Destroy())
    acercaGui.Show("AutoSize Center")
    Sleep(1000)
    VerificarUltimaVersion()
}

MostrarActualizacionDisponible(versionURL, nuevaVersion) {
    ;updGui := Gui("+AlwaysOnTop")
    updGui.Title := "Actualización Disponible"
    updGui.SetFont("s10", "Arial")
    updGui.Add("Text", "Center", "Hay una nueva versión disponible: " nuevaVersion)
    updGui.Add("Text", "Center", "Tu versión: " SCRIPT_VERSION)
    updGui.Add("Text", "Center", "Descárgala aquí:")
    link := updGui.Add("Text", "Center cBlue", versionURL)
    link.SetFont("Underline")
    link.OnEvent("Click", (*) => Run(versionURL))
    updGui.Add("Button", "Center w80", "OK").OnEvent("Click", (*) => updGui.Destroy())
    updGui.Show("AutoSize Center")
}

; OpenLink(url) {
;     Run(url)
; }

ActualizarEstado(msg) {
    myGui["Estado"].Value := msg
}