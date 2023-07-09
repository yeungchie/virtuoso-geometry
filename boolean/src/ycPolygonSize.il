;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonSize.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPolygonSize(polygon1 size \@key cvId(_ycMakeGeometryTempCellView()) "lng")
    ycPolygonBoolean(polygon1 size 'size ?cvId cvId)
)

; END
