#Requires AutoHotkey v2.0
#SingleInstance Force
SendMode("Input")
SetWorkingDir(A_ScriptDir)

; Aplicar Hotkeys solo si la ventana Doomsday.exe está activa
;#HotIf WinActive("ahk_exe DOOMSDAY.EXE")

configFile := A_ScriptDir "\config.ini"
global pararConsumir := false

; Si el archivo de configuración no existe, se crea con valores predeterminados
if !FileExist(configFile) {
    IniWrite(100, configFile, "Window", "X")
    IniWrite(100, configFile, "Window", "Y")
}

; Leer coordenadas desde el archivo de configuración
posX := IniRead(configFile, "Window", "X", 100)
posY := IniRead(configFile, "Window", "Y", 100)

; Crear la GUI
myGui := Gui("+AlwaysOnTop +ToolWindow +Border")
myGui.SetFont("s11", "Arial")

myGui.Add("Text", "Center", "[Asignación de Teclas]")
myGui.Add("Text", "Center", "F1 → Matar Zombies")
myGui.Add("Text", "Center", "F2 → Obtener Posición del Puntero")
myGui.Add("Text", "Center", "F3 → Consumir Stamina")
myGui.Add("Text", "Center", "R  → Recargar Script")
myGui.Add("Text", "Center", "E  → Salir del Script")
myGui.Add("Text", "Center w300 vEstado", "Esperando comando...")

myGui.Show("AutoSize")
WinMove(posX, posY,,,myGui)

ActualizarEstado(msg) {
    myGui["Estado"].Value := msg
}

loopNiveles(ciclos) {
    static popUp := 400
    static noPopUp := 120
    static stdSped := 90
    static clickSpd := 80

    Loop ciclos {
        ClickPos(41, 644, stdSped, clickSpd, popUp)
        ClickPos(329, 593, stdSped, clickSpd, noPopUp)
        ClickPos(194, 661, stdSped, clickSpd, popUp*2)
        ClickPos(570, 452, stdSped, clickSpd, popUp)
        ClickPos(869, 624, stdSped, clickSpd, popUp)
        ClickPos(880, 320, stdSped, clickSpd, popUp)
        ClickPos(860, 712, stdSped, clickSpd, popUp)
    }
}

consumeStamina(*) {
    static espera := 300
    pararConsumir := false

    Loop {
        if pararConsumir
            break
        ClickPos(657, 456, 50, 50, espera)
        ClickPos(580, 695, 50, 50, espera)
        ClickPos(864, 713, 50, 50, espera)
        ClickPos(600, 701, 50, 50, espera)
        ClickPos(657, 515, 50, 50, espera)
        ClickPos(736, 603, 50, 50, espera)
        ClickPos(588, 707, 50, 50, espera)
    }
    MsgBox("Se detuvo el consumo de stamina.", "Cancelado")
}

mataZombies(*) {
    static staminaZombie := 77
    stamina := InputBox("Ingresa cuanta stamina tienes actualmente:", "Stamina Disponible")
    if (!stamina) {
        MsgBox("Cancelaste la operación.", "Cancelado")
        return
    }

    totalNiveles := Floor(stamina / (2 * staminaZombie))
    ciclosCompletos := Floor(totalNiveles / 5)
    nivelesRestantes := Mod(totalNiveles, 5)

    if totalNiveles < 1 {
        MsgBox("No tienes suficiente stamina para zombiar.", "Insuficiente Stamina")
        return
    }

    MsgBox("Se ejecutarán " ciclosCompletos " ciclos de 5 niveles y 1 ciclo con " nivelesRestantes " niveles.")

    Sleep(500)
    Loop ciclosCompletos {
        loopNiveles(5)
    }
    if nivelesRestantes > 0 {
        loopNiveles(nivelesRestantes)
    }

    MsgBox("El matazombies ha finalizado. ¡Buen trabajo!", "Finalizado")
}

posicionPuntero(*) {
    MouseGetPos(&posX, &posY)
    coordenadasFile := A_ScriptDir "\coordenadas.txt"

    titulo := InputBox("Ingresa un título o descripción:", "Guardar coordenadas")

    if (!titulo) {
        MsgBox("Operación cancelada.", "Cancelado")
        return
    }

    file := FileOpen(coordenadasFile, "a")
    if !file {
        MsgBox("Error al abrir o crear el archivo: " coordenadasFile, "Error")
        return
    }

    file.WriteLine("ClickPos(" . posX . ", " . posY . ", 50, 50, 300) " ';' " [" . titulo.Value . "]")
    file.Close()
}

ClickPos(x, y, movSpeed, clickSpeed, wait) {
    MouseMove(x, y, movSpeed)
    Sleep(clickSpeed)
    Click("Down")
    Sleep(clickSpeed)
    Click("Up")
    Sleep(wait)
}

F1::(ActualizarEstado("Ejecutando: Matar Zombies..."), mataZombies(), ActualizarEstado("Esperando comando..."))
F2::(ActualizarEstado("Ejecutando: Obtener Posición..."), posicionPuntero(), ActualizarEstado("Esperando comando..."))
F3::(ActualizarEstado("Ejecutando: Consumir Stamina..."), consumeStamina(), ActualizarEstado("Esperando comando..."))
R::(ActualizarEstado("Recargando script..."), Sleep(500), Reload())
S::pararConsumir := true

E:: {
    WinGetPos(&posX, &posY, , , myGui)
    IniWrite(posX, configFile, "Window", "X")
    IniWrite(posY, configFile, "Window", "Y")
    ExitApp()
}

myGui.OnEvent("Close", exit_script)
exit_script(*) => (
    WinGetPos(&posX, &posY, , , myGui)
    IniWrite(posX, configFile, "Window", "X")
    IniWrite(posY, configFile, "Window", "Y")
    ExitApp()
)
