;--------------------------
; Program  : virtuoso-geometry(line/ycGetJunctionByCoef.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 通过直线系数来获取直线到直线的交点

procedure(ycGetJunctionByCoef(coef1 coef2 "ll")
    let((A1 B1 C1 A2 B2 C2 x y)
        ; A1 * x + B1 * y + C1 = 0      <1>
        ; A2 * x + B2 * y + C2 = 0      <2>
        ;
        ;      B2 * C1 - B1 * C2
        ; x = -------------------
        ;      A2 * B1 - A1 * B2
        ;
        ;             A1 * x + C1             A2 * x + C2
        ; y = -1.0 * ------------- or -1.0 * -------------
        ;                  B1                      B2

        A1 = coef1->A * 1.0
        B1 = coef1->B * 1.0
        C1 = coef1->C * 1.0
        A2 = coef2->A * 1.0
        B2 = coef2->B * 1.0
        C2 = coef2->C * 1.0

        unless(abs(A2 * B1 - A1 * B2 - 0.0) < 1e-10
            x = (B2 * C1 - B1 * C2) / (A2 * B1 - A1 * B2)
            y = if(abs(B1 - 0.0) < 1e-10
                -1.0 * (A2 * x + C2) / B2
                -1.0 * (A1 * x + C1) / B1
            )
            list(x y)
        )
    )
); ycGetJunctionByCoef

; END
