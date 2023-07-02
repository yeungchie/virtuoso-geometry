;--------------------------
; Program  : virtuoso-geometry(point/ycSnapPointToGrid.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
; Version  : 2022.07.20
;--------------------------

procedure(ycSnapPointToGrid(point grid "ln")
    unless(isLocation(point)
        ycError("argument #1 should be a point - %A" point)
    )
    grid *= 1.0
    point = foreach(mapcar x point
        let((pitch valid)
            pitch = x / grid
            valid = fix2(pitch + 0.5)
            grid * valid
        )
    )
); ycSnapPointToGrid

; END
