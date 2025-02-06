#Requires AutoHotkey v2.0

global popUp := 400
global noPopUp := 120
global stdSped := 90
global clickSpd := 80

ClickPos(x, y, movSpeed, clickSpeed, wait) {
    MouseMove(x, y, movSpeed)
    Sleep(clickSpeed)
    Click("Down")
    Sleep(clickSpeed)
    Click("Up")
    Sleep(wait)
}

EnfocarJuego(*){
    if WinExist("ahk_exe Doomsday.exe") {
        WinActivate
        Sleep 500  ; Esperar un momento para asegurarse de que la ventana esté activa
    }
}

LoopNiveles(ciclos) {
    ; static popUp := 400
    ; static noPopUp := 120
    ; static stdSped := 90
    ; static clickSpd := 80

    Loop ciclos {
        ; ascendente
        ClickPos( 40, 618, stdSped, clickSpd, popUp) ; [lupa]
        ClickPos(328, 567, stdSped, clickSpd, popUp) ; [+]
        ClickPos(201, 639, stdSped, clickSpd, popUp*2) ; [search]
        ClickPos(565, 441, stdSped, clickSpd, popUp) ; [zombie]
        ClickPos(864, 601, stdSped, clickSpd, popUp) ; [attack]
        ClickPos(873, 296, stdSped, clickSpd, popUp) ; [squad]
        ClickPos(853, 691, stdSped, clickSpd, popUp) ; [march]
    }
    ; descendente
    Loop ciclos{
        ClickPos( 40, 618, stdSped, clickSpd, popUp) ; [lupa]
        ClickPos( 65, 562, stdSped, clickSpd, popUp) ; [-]
        ClickPos(201, 639, stdSped, clickSpd, popUp*2) ; [search]
        ClickPos(565, 441, stdSped, clickSpd, popUp) ; [zombie]
        ClickPos(864, 601, stdSped, clickSpd, popUp) ; [attack]
        ClickPos(873, 296, stdSped, clickSpd, popUp) ; [squad]
        ClickPos(853, 691, stdSped, clickSpd, popUp) ; [march]
    }
}

ConsumeStamina(*) {
    global pararConsumir
    static espera := 300
    pararConsumir := false

    Loop {
        if pararConsumir
            break
        ClickPos(657, 456, 50, 50, espera)
        if pararConsumir
            break
        ClickPos(580, 695, 50, 50, espera)
        if pararConsumir
            break
        ClickPos(864, 713, 50, 50, espera)
        if pararConsumir
            break
        ClickPos(600, 701, 50, 50, espera)
        if pararConsumir
            break
        ClickPos(657, 515, 50, 50, espera)
        if pararConsumir
            break
        ClickPos(736, 603, 50, 50, espera)
        if pararConsumir
            break
        ClickPos(588, 707, 50, 50, espera)
    }
    MsgBox("Se detuvo el consumo de stamina.", "Cancelado")
}

MataZombies(*) {
    static staminaZombie := 78
    stamina := InputBox("Ingresa cuanta stamina tienes actualmente:", "Stamina Disponible")
    if (!stamina) {
        MsgBox("Cancelaste la operación.", "Cancelado")
        return
    }

    totalNiveles := Floor(stamina.Value / (staminaZombie))
    ciclosCompletos := Floor(totalNiveles / 5)
    nivelesRestantes := Mod(totalNiveles, 5)

    if totalNiveles < 1 {
        MsgBox("No tienes suficiente stamina para zombiar.", "Insuficiente Stamina")
        return
    }

    MsgBox("Se ejecutarán " ciclosCompletos " ciclos de 5 niveles y 1 ciclo con " nivelesRestantes " niveles.")

    EnfocarJuego()
    Loop ciclosCompletos {
        LoopNiveles(5)
    }
    if nivelesRestantes > 0 {
        LoopNiveles(nivelesRestantes)
    }

    MsgBox("El matazombies ha finalizado. ¡Buen trabajo!", "Finalizado")
}

PosicionPuntero(*) {
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
    file.WriteLine("ClickPos(" . posX . ", " . posY . ", stdSped, clickSpd, popUp) " ';' " [" . titulo.Value . "]")
    file.Close()
}

Recolectar(recurso) {
    ; MsgBox("Recolectando " recurso "...", "Proceso")
    if (recurso == "Comida") {
        ClickPos( 39, 617, stdSped, clickSpd, popUp)    ; [lupa]
        ClickPos(499, 765, stdSped, clickSpd, popUp)    ; [comida]
        ClickPos(495, 637, stdSped, clickSpd, popUp*5/2)  ; [buscarComida]
        ClickPos(563, 427, stdSped, clickSpd, popUp)    ; [clickRecurso]
        ClickPos(872, 572, stdSped, clickSpd, popUp)    ; [recolectar]
        ClickPos(876, 328, stdSped, clickSpd, popUp*2)    ; [crearSquad]
        ClickPos(987, 333, stdSped, clickSpd, popUp)    ; [squadComida]
        ClickPos(857, 686, stdSped, clickSpd, popUp)    ; [marchar]
    }
    else if (recurso == "Madera") {
        ClickPos( 40, 618, stdSped, clickSpd, popUp)    ; [lupa]
        ClickPos(645, 769, stdSped, clickSpd, popUp)    ; [madera]
        ClickPos(642, 636, stdSped, clickSpd, popUp*5/2)  ; [buscarMadera]
        ClickPos(556, 431, stdSped, clickSpd, popUp)    ; [clickRecurso]
        ClickPos(869, 574, stdSped, clickSpd, popUp)    ; [gatherRecurso]
        ClickPos(865, 327, stdSped, clickSpd, popUp*2)    ; [crearSquad]
        ClickPos(989, 387, stdSped, clickSpd, popUp)    ; [squadMadera]
        ClickPos(857, 682, stdSped, clickSpd, popUp)    ; [march]
    }
    else if (recurso == "Acero") {
        ClickPos( 40, 618, stdSped, clickSpd, popUp)    ; [lupa]
        ClickPos(797, 774, stdSped, clickSpd, popUp)    ; [acero]
        ClickPos(794, 637, stdSped, clickSpd, popUp*5/2)  ; [buscarAcero]
        ClickPos(557, 432, stdSped, clickSpd, popUp)    ; [clickRecurso]
        ClickPos(869, 574, stdSped, clickSpd, popUp)    ; [gatherRecurso]
        ClickPos(865, 327, stdSped, clickSpd, popUp*2)    ; [crearSquad]
        ClickPos(985, 440, stdSped, clickSpd, popUp)    ; [squadAcero]
        ClickPos(857, 682, stdSped, clickSpd, popUp)    ; [march]
    }
    else if (recurso == "Petroleo") {
        ClickPos( 40, 618, stdSped, clickSpd, popUp)    ; [lupa]
        ClickPos(942, 769, stdSped, clickSpd, popUp)    ; [petroleo]
        ClickPos(939, 635, stdSped, clickSpd, popUp*5/2)  ; [buscarPetroleo]
        ClickPos(557, 432, stdSped, clickSpd, popUp)    ; [clickRecurso]
        ClickPos(869, 574, stdSped, clickSpd, popUp)    ; [gatherRecurso]
        ClickPos(865, 327, stdSped, clickSpd, popUp*2)    ; [crearSquad]
        ClickPos(986, 496, stdSped, clickSpd, popUp)    ; [squadPetroleo]
        ClickPos(857, 682, stdSped, clickSpd, popUp)    ; [march]
    }
}

RecolectarRecursos(*) {
    respuesta := MsgBox("¿Estás recolectando para la alianza?",, 4)
    EnfocarJuego()
    if (respuesta == "No") {
        ; Proceder con la recolección de los 4 recursos
        Recolectar("Comida")
        Recolectar("Madera")
        Recolectar("Acero")
        Recolectar("Petroleo")
    } else {
        ; Mostrar opciones en pantalla para seleccionar recurso mediante un número
        global recursoGui := Gui("+AlwaysOnTop")
        recursoGui.SetFont("s10", "Arial")
        recursoGui.Add("Text", "Center", "Selecciona el recurso que estás recolectando para la alianza:")
        recursoGui.Add("Radio", "vComida", "1. Comida")
        recursoGui.Add("Radio", "vMadera", "2. Madera")
        recursoGui.Add("Radio", "vAcero", "3. Acero")
        recursoGui.Add("Radio", "vPetroleo", "4. Petroleo")
        recursoGui.Add("Button", "Default w80", "Aceptar").OnEvent("Click", AceptarRecurso)
        recursoGui.Show("AutoSize Center")
    }
}

AceptarRecurso(*) {
    global recursoGui
    recursoGui.Submit()
    recurso := ""
    if (recursoGui["Comida"].Value)
        recurso := "Comida"
    else if (recursoGui["Madera"].Value)
        recurso := "Madera"
    else if (recursoGui["Acero"].Value)
        recurso := "Acero"
    else if (recursoGui["Petroleo"].Value)
        recurso := "Petroleo"
    recursoGui.Destroy()
    EnfocarJuego()
    ProcederRecoleccion(recurso)
}

ProcederRecoleccion(RecursoSeleccionado) {
    recursos := ["Comida", "Madera", "Acero", "Petroleo"]
    for _, recurso in recursos {
        if (recurso != RecursoSeleccionado) {
            Recolectar(recurso)
        }
    }
}
