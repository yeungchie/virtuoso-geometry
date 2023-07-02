;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonSize.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonSize(polygon1 size \@key cvId(_ycMakeGeometryTempCellView()) "lng")
    ycPolygonBoolean('size polygon1 size ?cvId cvId)
)

; END
