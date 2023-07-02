;--------------------------
; Program  : virtuoso-geometry(bbox/ycGetBBoxSize.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取 bBox 尺寸

procedure(ycGetBBoxSize(bBox \@optional edge "lg")
    let((x1 y1 x2 y2 width height)
        unless(isBBox(bBox)
            ycError("arguments #1 should be a bBox - %A" bBox)
        )
        ycBBoxAssign(ycBBox(bBox) 'x1 'y1 'x2 'y2)
        width  = abs(x1 - x2)
        height = abs(y1 - y2)
        case(edge
            (nil    list(width height))
            (width  width)
            (height height)
            (t
                ycError("arguments #2 should be a symbol and one of the 'width, 'height, or nil - %A" edge)
            )
        )
    )
)

; END
