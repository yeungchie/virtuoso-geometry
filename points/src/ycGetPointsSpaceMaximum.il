;--------------------------
; Program  : virtuoso-geometry(points/ycGetPointsSpaceMaximum.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取一堆点的间距的最大值

procedure(ycGetPointsSpaceMaximum(points \@optional findLocation "lg")
    ycGetPointsSpaceExtremum('max points findLocation)
)

; END
