;--------------------------
; Program  : virtuoso-geometry(bbox/ycBBoxToPoints.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; bBox 转为其顶点组成的 points

procedure(ycBBoxToPoints(bBox "l")
    let((x1 y1 x2 y2)
        unless(isBBox(bBox)
            ycError("arguments #1 should be a bBox - %A" bBox)
        )
        ycBBoxAssign(ycBBox(bBox) 'x1 'y1 'x2 'y2)
        list(
            x1 : y1
            x2 : y1
            x2 : y2
            x1 : y2
        )
    )
); ycBBoxToPoints

; END
