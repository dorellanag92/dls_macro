#Requires AutoHotkey v2.0

CrearGUI() {
    ;myGui := Gui("+AlwaysOnTop +ToolWindow +Border")
    myGui.SetFont("s11", "Arial")
    myGui.Title := "DLS Macro"
    myGui.Add("Text", "Center", "[Asignación de Teclas]")
    myGui.Add("Text", "Center", "F1 → Matar Zombies")
    myGui.Add("Text", "Center", "F2 → Obtener Posición del Puntero")
    myGui.Add("Text", "Center", "F3 → Consumir Stamina")
    myGui.Add("Text", "Center", "F4 → Recolectar Recursos")
    myGui.Add("Text", "Center", "R  → Recargar Script")
    myGui.Add("Text", "Center", "E  → Salir del Script")
    myGui.Add("Text", "Center w300 vEstado", "Esperando comando...")
    myGui.Add("Button", "Center w80", "Acerca de").OnEvent("Click", MostrarAcercaDe)
}

MostrarAcercaDe(*) {
    acercaGui := Gui("+Owner" myGui.Hwnd)  ; Hacer que la ventana principal sea su dueña
    acercaGui.Title := "Acerca de"
    acercaGui.SetFont("s10", "Arial")
    
    acercaGui.Add("Text", "Center w300", "Versión: " SCRIPT_VERSION)
    acercaGui.Add("Text", "Center w300", CREDITOS)
    acercaGui.Add("Button", "Default w100", "OK").OnEvent("Click", (*) => acercaGui.Destroy())
    
    acercaGui.Show("AutoSize Center")
}

ActualizarEstado(msg) {
    myGui["Estado"].Value := msg
}