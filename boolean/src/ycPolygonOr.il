;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonOr.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonOr(polygon1 \@optional polygon2 "ll")
    ycPolygonBoolean(polygon1 polygon2 'or)
)

; END
