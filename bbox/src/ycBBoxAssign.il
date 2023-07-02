;--------------------------
; Program  : virtuoso-geometry(bbox/ycBBoxAssign.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 快速赋值 bBox 的四个特征坐标值

procedure(ycBBoxAssign(bBox \@rest syms "lg")
    let((num p1 p2 coords)
        unless(isBBox(bBox)
            ycError("arguments #1 should be a bBox - %A" bBox)
        )
        num = 2
        foreach(x syms
            when(num > 5
                ycError("too many arguments (at most 5 expected, %d given) - %A" num cons(bBox syms))
            )
            when(x && !symbolp(x)
                ycError("the argument #%d should be a symbol - %A" num x)
            )
            num++
        )
        bBox = ycBBox(bBox)
        p1 = car(bBox)
        p2 = cadr(bBox)
        coords = list(xCoord(p1) yCoord(p1) xCoord(p2) yCoord(p2))
        foreach(mapcar (coord sym) coords syms
            when(sym && symbolp(sym)
                set(sym coord)
            )
        )
    )
)

; END
