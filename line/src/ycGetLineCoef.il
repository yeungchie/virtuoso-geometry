;--------------------------
; Program  : virtuoso-geometry(line/ycGetLineCoef.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取两点确定的直线的系数和其他特征参数
; 直线方程一般式: Ax + By + C = 0
; coef->A -------^    ^    ^
; coef->B ------------|    |
; coef->C -----------------|
; coef->k -------> 斜率
; coef->ori -----> 方向 ( 垂直 "V", 水平 "H", 斜线 "X" )

procedure(ycGetLineCoef(line "l")
    let((x1 y1 x2 y2 k b coef)
        unless(isBBox(line)
            ycError("argument #1 should be a line - %A" line)
        )

        x1 = xCoord(car(line))  * 1.0
        y1 = yCoord(car(line))  * 1.0
        x2 = xCoord(cadr(line)) * 1.0
        y2 = yCoord(cadr(line)) * 1.0
        when(abs(x1 - x2) < 1e-10 && abs(y1 - y2) < 1e-10
            ycError("not a valid line - %A" line)
        )

        coef = list(nil)

        cond(
            ( abs(x1 - x2) < 1e-10  ; parallel to Y axis
                coef->A = 1.0
                coef->B = 0.0
                coef->C = -x1
                coef->k = 1e999     ; infinity
                coef->ori = "V"
            )
            ( abs(y1 - y2) < 1e-10  ; parallel to X axis
                coef->A = 0.0
                coef->B = 1.0
                coef->C = -y1
                coef->k = 0.0
                coef->ori = "H"
            )
            ( t
                ; A*x + B*y + C = 0     <1>
                ; y = k * x + b         <2>
                ;
                ; y -  y1    x - x1 
                ; ------- = -------     <3>
                ; y2 - y1   x2 - x1
                ;
                ; k = ( y2 - y1 ) / ( x2 - x1 )
                ; b = y1 - k * x1

                k = (y2 - y1) / (x2 - x1)
                b = y1 - k * x1
                ; y = k * x + b ==> k * x - y + b = 0
                coef->A = k
                coef->B = -1.0
                coef->C = b
                coef->k = k
                coef->ori = "X"
            )
        ); cond
        
        coef
    )
); ycGetLineCoef

; END
