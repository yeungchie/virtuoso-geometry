;--------------------------
; Program  : virtuoso-geometry(points/ycGetPointsSpaceMinimum.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取一堆点的间距的最小值

procedure(ycGetPointsSpaceMinimum(points \@optional findLocation "lg")
    ycGetPointsSpaceExtremum('min points findLocation)
)

; END
