;--------------------------
; Program  : virtuoso-geometry(line/ycGetJunction.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 直线到直线的交点
; 当 segment 为 t 时将 line 视为线段，交点在线段之外的返回 nil

procedure(ycGetJunction(line1 line2 \@optional segment "llg")
    prog((coef1 coef2 A1 B1 C1 A2 B2 C2 x y)
        unless(isBBox(line1)
            ycError("argument #1 should be a line - %A" line1)
        )
        unless(isBBox(line2)
            ycError("argument #2 should be a line - %A" line2)
        )

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

        coef1 = ycGetLineCoef(line1)
        coef2 = ycGetLineCoef(line2)
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
            when(segment
                let((
                        p11 p12 xMin1 xMax1 yMin1 yMax1
                        p21 p22 xMin2 xMax2 yMin2 yMax2
                        xMin xMax yMin yMax
                    )
                    p11 = car(line1)
                    p12 = cadr(line1)
                    xMin1 = min(xCoord(p11) xCoord(p12))
                    xMax1 = max(xCoord(p11) xCoord(p12))
                    yMin1 = min(yCoord(p11) yCoord(p12))
                    yMax1 = max(yCoord(p11) yCoord(p12))

                    p21 = car(line2)
                    p22 = cadr(line2)
                    xMin2 = min(xCoord(p21) xCoord(p22))
                    xMax2 = max(xCoord(p21) xCoord(p22))
                    yMin2 = min(yCoord(p21) yCoord(p22))
                    yMax2 = max(yCoord(p21) yCoord(p22))

                    xMin = max(xMin1 xMin2)
                    xMax = min(xMax1 xMax2)
                    yMin = max(yMin1 yMin2)
                    yMax = min(yMax1 yMax2)

                    unless(xMin < xMax  || abs(xMin - xMax) < 1e-10
                        return()    ; X 轴没有重叠
                    )
                    unless(yMin < yMax  || abs(yMin - yMax) < 1e-10
                        return()    ; Y 轴没有重叠
                    )
                    unless(x > xMin && x < xMax || abs(x - xMin) < 1e-10 || abs(x - xMax) < 1e-10
                        return()    ; 交点不在 X 轴重叠区间
                    )
                    unless(y > yMin && y < yMax || abs(y - yMin) < 1e-10 || abs(y - yMax) < 1e-10
                        return()    ; 交点不在 Y 轴重叠区间
                    )
                )
            )
            return(list(x y))
        )
    )
); ycGetJunction
; END
