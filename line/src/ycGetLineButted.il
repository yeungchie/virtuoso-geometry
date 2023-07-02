;--------------------------
; Program  : virtuoso-geometry(line/ycGetLineButted.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取多个线段之间相互重叠的线段
; lines = '(
;     (( 0 0 ) ( 2 0 ))
;     (( 1 0 ) ( 3 0 ))
; )
; ycGetLineButted(lines)
; (( 1 0 ) ( 2 0 ))

procedure(ycGetLineButted(\@rest lines "l")
    prog((count line1 coef1 k1 C1)
        unless((count = length(lines)) >= 2
            ycError("too few arguments (at least 2 expected, %d given) - %A" count lines)
        )
        line1 = car(lines)
        unless(isBBox(line1)
            ycError("all of the arguments should be a line - %A" line1)
        )
        coef1 = ycGetLineCoef(line1)
        k1 = coef1->k
        C1 = coef1->C

        foreach(line2 cdr(lines) let((coef2 k2 C2 p11 p12 p21 p22 p11j p12j p21j p22j butted)

            coef2 = ycGetLineCoef(line2)
            k2 = coef2->k
            C2 = coef2->C
            unless((k1 == k2) || (k1 - k2) < 1e-10
                return()
            )
            unless((C1 == C2) || (C1 - C2) < 1e-10
                return()
            )

            p11 = car(line1)
            p12 = cadr(line1)
            p11j = ycGetProjection(p11 line2 t)
            p12j = ycGetProjection(p12 line2 t)
            when(p11j && p12j
                butted = list(p11j p12j)
            )

            p21 = car(line2)
            p22 = cadr(line2)
            p21j = ycGetProjection(p21 line1 t)
            p22j = ycGetProjection(p22 line1 t)
            when(p21j && p22j
                butted = list(p21j p22j)
            )

            if(line1 = butted || setof(x list(p11j p12j p21j p22j) x)
                when(ycGetLineLength(line1) < 1e-10
                    return()
                )
                return()
            )
        ))
        return(line1)
    )
); ycGetLineButted

; END
