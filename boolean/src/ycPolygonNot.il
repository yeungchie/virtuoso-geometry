;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonNot.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonNot(polygon1 polygon2 "ll")
    ycPolygonBoolean('not polygon1 polygon2)
)

; END
