;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonOr.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonOr(polygon1 polygon2 \@key cvId(_ycMakeGeometryTempCellView()) "llg")
    ycPolygonBoolean(polygon1 polygon2 'or ?cvId cvId)
)

; END
