;--------------------------
; Program  : virtuoso-geometry(points/ycGetPolygonArea.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取多边形面积

procedure(ycGetPolygonArea(points "l")
    let((i(0) b area(0))
        foreach(a points
            unless(isLocation(a)
                ycError("arguments #1 is not a valid point list - %A" a)
            )
            b = nth(i points) || car(points)
            area += xCoord(a)*yCoord(b) - yCoord(a)*xCoord(b)
            i++
        )
        abs(area)/2
    )
); ycGetPolygonArea

; END
