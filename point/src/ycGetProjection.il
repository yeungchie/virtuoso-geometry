;--------------------------
; Program  : virtuoso-geometry(point/ycGetProjection.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取点到直线的投影
; 当 segment 为 t 时将 line 视为线段，投影点在线段之外的返回 nil

procedure(ycGetProjection(point line \@optional segment "llg")
    prog((x1 y1 x2 y2 coef k b A B C)
        unless(isLocation(point)
            ycError("argument #1 should be a point - %A" point)
        )
        unless(isBBox(line)
            ycError("argument #2 should be a line - %A" line)
        )

        x1 = xCoord(point) * 1.0
        y1 = yCoord(point) * 1.0
        coef = ycGetLineCoef(line)
        case(coef->ori
            ("V"
                x2 = -1.0 * coef->C
                y2 = y1
            )
            ("H"
                x2 = x1
                y2 = -1.0 * coef->C
            )
            (t
                ; y1 = k * x1 + b           <1>
                ; b = y1 - k * x1
                ;
                ; y2 = k * x2 + b           <2>
                ; A * x2 + B * y2 + C = 0   <3>
                ;
                ;      B * b + C
                ; x2 + --------- = 0
                ;      B * k + A

                k = -1.0 / coef->k
                A = coef->A
                B = coef->B
                C = coef->C

                b = y1 - k * x1
                x2 = -(B * b + C)/(B * k + A)
                y2 = k * x2 + b
            )
        )

        when(segment
            let((p1 p2 xMin xMax yMin yMax)
                p1 = car(line)
                p2 = cadr(line)
                xMin = min(xCoord(p1) xCoord(p2))
                xMax = max(xCoord(p1) xCoord(p2))
                yMin = min(yCoord(p1) yCoord(p2))
                yMax = max(yCoord(p1) yCoord(p2))

                ; A.
                ;      \   B.
                ;       \
                ;        \
                ;
                ; 点 A 投影到线段之外 => return(nil)
                ; 点 B 投影到线段之内 => return(projection)

                unless(x2 > xMin && x2 < xMax || abs(x2 - xMin) < 1e-10 || abs(x2 - xMax) < 1e-10
                    return()    ; 投影不在 X 轴重叠区间
                )
                unless(y2 > yMin && y2 < yMax || abs(y2 - yMin) < 1e-10 || abs(y2 - yMax) < 1e-10
                    return()    ; 投影不在 Y 轴重叠区间
                )
            )
        )

        return(list(x2 y2))
    )
); ycGetProjection

; END
