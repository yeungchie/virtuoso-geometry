;--------------------------
; Program  : virtuoso-geometry(bbox/ycIsValidBBox.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 检查是否为有效的 bBox

procedure(ycIsValidBBox(bBox \@optional eps(1e-9) "ln")
    let((x1 y1 x2 y2 width height)
        unless(isBBox(bBox)
            ycError("arguments #1 should be a bBox - %A" bBox)
        )

        eps *= 1.0

        ycBBoxAssign(ycBBox(bBox) 'x1 'y1 'x2 'y2)

        width  = abs(x1 - x2)
        height = abs(y1 - y2)

        (width  > eps || abs(width  - eps) < eps) &&
        (height > eps || abs(height - eps) < eps) &&
        t
    )
)

; END
