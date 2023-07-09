;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonXor.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonXor(polygon1 polygon2 \@key cvId(_ycMakeGeometryTempCellView()) "llg")
    ycPolygonBoolean(polygon1 polygon2 'xor ?cvId cvId)
)

; END
