;--------------------------
; Program  : virtuoso-geometry(points/ycGetPolygonEqualBBox.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取多边形的等效矩形
; 有则返回 bBox
; 无则返回 nil

procedure(ycGetPolygonEqualBBox(points "l")
    prog((xMap yMap xlist ylist)
        xMap = makeTable("" nil)
        yMap = makeTable("" nil)
        foreach(p points
            unless(isLocation(p)
                ycError("argument #1 is not a valid point list - %A" points)
            )
            xMap[lsprintf("%.10f" xCoord(p)*1.0)] = t
            yMap[lsprintf("%.10f" yCoord(p)*1.0)] = t
        )
        unless(length(xMap) == 2
            return()
        )
        unless(length(yMap) == 2
            return()
        )
        xlist = sort(mapcar('atof xMap~>?) 'lessp)
        ylist = sort(mapcar('atof yMap~>?) 'lessp)
        return(list(
            car(xlist)  : car(ylist)
            cadr(xlist) : cadr(ylist)
        ))
    )
)

procedure(ycGetPolygonEqualBBox(points "l")
    let((bBox pts)
        bBox = ycPointsToBBox(points)
        pts = ycBBoxToPoints(bBox)
        unless(ycPolygonNot(pts points)
            bBox
        )
    )
)

; END
