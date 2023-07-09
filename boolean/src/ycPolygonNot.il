;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonNot.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonNot(polygon1 polygon2 \@key cvId(_ycMakeGeometryTempCellView()) "llg")
    ycPolygonBoolean(polygon1 polygon2 'not ?cvId cvId)
)

; END
