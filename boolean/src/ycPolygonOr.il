;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonOr.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonOr(polygon1 polygon2 \@key cvId(_ycMakeGeometryTempCellView()) "llg")
    ycPolygonBoolean('or polygon1 polygon2 ?cvId cvId)
)

; END
