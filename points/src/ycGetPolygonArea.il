;--------------------------
; Program  : virtuoso-geometry(points/ycGetPolygonArea.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取多边形面积

procedure(ycGetPolygonArea(points "l")
    let((area(0.0))
        foreach((a b) points nconc(copy(cdr(points)) list(car(points)))
            unless(isLocation(a)
                ycError("arguments #1 is not a valid point list - %A" a)
            )
            area += (xCoord(a)*yCoord(b) - yCoord(a)*xCoord(b))
        )
        abs(area)/2
    )
); ycGetPolygonArea

; END

points = list(2:2 1:2 1:1 0:1 0:0 2:0)