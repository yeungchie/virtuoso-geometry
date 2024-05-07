;--------------------------
; Program  : virtuoso-geometry(points/ycGetPolygonEqualBBox.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取多边形的等效矩形
; 有则返回 bBox
; 无则返回 nil

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
