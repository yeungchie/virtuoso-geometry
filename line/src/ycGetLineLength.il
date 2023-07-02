;--------------------------
; Program  : virtuoso-geometry(line/ycGetLineLength.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGetLineLength(line "l")
    let((width height)
        unless(isBBox(line)
            ycError("argument #1 should be a line - %A" line)
        )
        width  = abs(xCoord(car(line)) - xCoord(cadr(line))) * 1.0
        height = abs(yCoord(car(line)) - yCoord(cadr(line))) * 1.0
        sqrt(width ** 2 + height ** 2)
    )
); ycGetLineLength

; END
