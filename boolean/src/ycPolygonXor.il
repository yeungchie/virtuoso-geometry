;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonXor.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonXor(polygon1 polygon2 \@key cvId(_ycMakeGeometryTempCellView()) "llg")
    ycPolygonBoolean('xor polygon1 polygon2 ?cvId cvId)
)

; END
