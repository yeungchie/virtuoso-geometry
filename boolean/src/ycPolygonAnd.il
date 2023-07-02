;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonAnd.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonAnd(polygon1 polygon2 \@key cvId(_ycMakeGeometryTempCellView()) "llg")
    ycPolygonBoolean('and polygon1 polygon2 ?cvId cvId)
)

; END
