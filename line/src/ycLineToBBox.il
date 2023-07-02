;--------------------------
; Program  : virtuoso-geometry(line/ycLineToBBox.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycLineToBBox(line \@optional width(0.001) "ln")
    let((p1 p2 half coef)
        unless(isBBox(line)
            ycError("argument #1 should be a line - %A" line)
        )
        p1 = car(line)
        p2 = cadr(line)
        half = 0.5*width
        coef = ycGetLineCoef(line)
        case(coef->ori
            ("V"
                list(
                    -(coef->C) - half : yCoord(p1)
                    -(coef->C) + half : yCoord(p2)
                )
            )
            ("H"
                list(
                    xCoord(p1) : -(coef->C) - half
                    xCoord(p2) : -(coef->C) + half
                )
            )
            (t
                ycWarn("Cannot support orient type - %A" line)
            )
        )
    )
); ycLineToBBox

; END
