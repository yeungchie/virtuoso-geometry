;--------------------------
; Program  : virtuoso-geometry(bbox/ycGetBBoxWidth.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取 bBox 宽度

procedure(ycGetBBoxWidth(bBox "l")
    ycGetBBoxSize(bBox 'width)
)

; END
