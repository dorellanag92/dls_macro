#Requires AutoHotkey v2.0
#SingleInstance Force
; Configurar el entorno
SendMode("Input")
SetWorkingDir(A_ScriptDir)
; Aplicar Hotkeys solo si la ventana Doomsday.exe está activa
#HotIf WinActive("ahk_exe Doomsday.exe")
; Importar archivos necesarios
#Include controller\controller.ahk
#Include view\view.ahk
#Include config.ahk

InitConfig()
CrearGUI()
myGui.Show("AutoSize")
WinMove(posX, posY,,, myGui)

F1::(ActualizarEstado("Ejecutando: Matar Zombies..."), mataZombies(), ActualizarEstado("Esperando comando..."))
F2::(ActualizarEstado("Ejecutando: Obtener Posición..."), posicionPuntero(), ActualizarEstado("Esperando comando..."))
F3::(ActualizarEstado("Ejecutando: Consumir Stamina..."), consumeStamina(), ActualizarEstado("Esperando comando..."))
F4::(ActualizarEstado("Ejecutando: Recolectar Recursos..."), RecolectarRecursos(), ActualizarEstado("Esperando comando..."))
R::(ActualizarEstado("Recargando script..."), Sleep(500), Reload())
S::SetTimer(StopStamina, -10)
StopStamina(*){
    global pararConsumir := true
}
E::CerrarScript()
myGui.OnEvent("Close", CerrarScript)
