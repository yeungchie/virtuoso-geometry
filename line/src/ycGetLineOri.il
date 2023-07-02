;--------------------------
; Program  : virtuoso-geometry(line/ycGetLineOri.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGetLineOri(line "l")
    let((x1 y1 x2 y2)
        unless(isBBox(line)
            ycError("argument #1 should be a line - %A" line)
        )

        x1 = xCoord(car(line))  * 1.0
        y1 = yCoord(car(line))  * 1.0
        x2 = xCoord(cadr(line)) * 1.0
        y2 = yCoord(cadr(line)) * 1.0

        cond(
            (abs(x1 - x2) < 1e-10   list("V" x1))
            (abs(y1 - y2) < 1e-10   list("H" y1))
            (t                      list("X" nil))
        )
    )
); ycGetLineOri

; END
