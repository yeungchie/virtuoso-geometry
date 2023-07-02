;--------------------------
; Program  : virtuoso-geometry(point/ycPointToBBox.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycPointToBBox(point \@optional width(0.001) height origin('center) "lngs")
    let((p1 p2)
        unless(isLocation(point)
            ycError("argument #1 should be a point - %A" point)
        )
        if(height
            unless(numberp(height)
                ycError("argument #3 should be a number - %A" height)
            )
            height = width
        )
        width  *= 1.0
        height *= 1.0
        case(origin
            (center
                p1 = rodAddToY(rodAddToX(point -0.5*width) -0.5*height)
                p2 = rodAddToY(rodAddToX(point  0.5*width)  0.5*height)
                list(p1 p2)
            )
            (leftBottom
                list(point rodAddToY(rodAddToX(point width) height))
            )
            (t
                ycError("argument #5 should be one of 'center or 'leftBottom - %A" origin)
            )
        )
    )
); ycPointToBBox

; END
