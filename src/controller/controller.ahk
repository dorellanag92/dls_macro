#Requires AutoHotkey v2.0

ClickPos(x, y, movSpeed, clickSpeed, wait) {
    MouseMove(x, y, movSpeed)
    Sleep(clickSpeed)
    Click("Down")
    Sleep(clickSpeed)
    Click("Up")
    Sleep(wait)
}

LoopNiveles(ciclos) {
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
    static staminaZombie := 77
    stamina := InputBox("Ingresa cuanta stamina tienes actualmente:", "Stamina Disponible")
    if (!stamina) {
        MsgBox("Cancelaste la operación.", "Cancelado")
        return
    }

    totalNiveles := Floor(stamina.Value / (2 * staminaZombie))
    ciclosCompletos := Floor(totalNiveles / 5)
    nivelesRestantes := Mod(totalNiveles, 5)

    if totalNiveles < 1 {
        MsgBox("No tienes suficiente stamina para zombiar.", "Insuficiente Stamina")
        return
    }

    MsgBox("Se ejecutarán " ciclosCompletos " ciclos de 5 niveles y 1 ciclo con " nivelesRestantes " niveles.")

    Sleep(500)
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

    file.WriteLine("ClickPos(" . posX . ", " . posY . ", 50, 50, 300) " ';' " [" . titulo.Value . "]")
    file.Close()
}

