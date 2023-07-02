;--------------------------
; Program  : virtuoso-geometry(bbox/ycBBoxSizePercent.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 百分比缩放 bBox

procedure(ycBBoxSizePercent(bBox percent \@optional mode('center) "lns")
    prog((x1 y1 x2 y2 width height xLen yLen newBox)
        unless(isBBox(bBox)
            ycError("arguments #1 should be a bBox - %A" bBox)
        )
        percent *= 1.0
        when(percent < 0 || abs(percent - 0) < 1e-9
            ycError("argument #2 should be > 0 - %g" percent)
        )
        ycBBoxAssign(ycBBox(bBox) 'x1 'y1 'x2 'y2)
        when(abs(percent - 1) < 1e-9
            return(list(x1:y1 x2:y2))
        )
        width  = x2 - x1
        height = y2 - y1
        newBox = case(mode
            (lowerLeft
                xLen = percent * width
                yLen = percent * height
                list(x1:y1 xLen:yLen)
            )
            (center
                xLen = (percent-1) * width
                yLen = (percent-1) * height
                list(
                    (x1 - xLen/2) : (y1 - yLen/2)
                    (x2 + xLen/2) : (y2 + yLen/2)
                )
            )
            (t
                ycError("argument #3 should be a symbol and one of the 'lowerLeft or 'center - %A" mode)
            )
        )
        return(newBox)
    )
)

; END
