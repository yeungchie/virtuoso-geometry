;--------------------------
; Program  : virtuoso-geometry(circle/ycCircleToPolygon.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycCircleToPolygon(origin radius \@optional sides(4) type('outside) initRatio(-0.25) "lnxsn")
    let((pi angle lines points)
        unless(isLocation(origin)
            ycError("argument #1 should be a point - %A" origin)
        )
        unless(radius > 0
            ycError("argument #2 should be > 0 - %A" radius)
        )
        unless(sides > 2 && sides <= 360
            ycError("argument #3 should be > 2 and <= 360 - %A" sides)
        )
        unless(member(type '(inside outside))
            ycError("argument #4 should be 'inside or outside - %A" type)
        )

        ; 获取 π
        pi = getq(defMathConstants(gensym()) PI)

        radius    *= 1.0
        initRatio *= 1.0

        ; 单个边跨越的角度
        angle = 360.0/sides

        ; 计算圆外切边
        for(x 0 sides-1
            let((rad sinv cosv xy p_)
                rad = pi*(x*angle + 360*initRatio)/180
                sinv = sin(rad)
                cosv = cos(rad)
                cond(
                    (abs(abs(sinv) - 0.0) < 1e-10   ; 垂直 X 轴
                        xy = cosv*radius : 0.0      ; 圆外切点
                        p_ = rodAddToY(xy 1.0)      ; 切线沿 Y 轴延长 1um
                    )
                    (abs(abs(sinv) - 1.0) < 1e-10   ; 垂直 Y 轴
                        xy = 0.0 : sinv*radius      ; 圆外切点
                        p_ = rodAddToX(xy 1.0)      ; 切线沿 X 轴延长 1um
                    )
                    (t
                        xy = cosv*radius : sinv*radius  ; 圆外顶点
                        p_ = radius/cosv : 0.0          ; 圆外顶点的延长线交于 X 轴
                    )
                )
                lines = cons(list(xy p_) lines)
            )
        )
        
        for(i 0 length(lines)-1
            let((pt)
                pt = case(type
                    (outside
                        ; 外部多边形需要计算相邻边交点形成正多边形(内切圆)
                        ycGetJunction(
                            nth(i   lines)
                            nth(i+1 lines) || car(lines)
                        )
                    )
                    (inside
                        ; 内部多边形直接使用外切点组成顶点(外切圆)
                        car(nth(i lines))
                    )
                )
                points = cons(rodAddPoints(pt origin) points)
            )
        )

        points
    )
); ycCircleToPolygon

; END
