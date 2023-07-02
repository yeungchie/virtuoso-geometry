;--------------------------
; Program  : virtuoso-geometry(points/ycIsPolygonEquilateral.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 判断多边形是否属于等边多边形

procedure(ycIsPolygonEquilateral(points \@optional ratio(0.01) sides(nil) "lfg")
    prog((end lengthList maxLen minLen)
        unless(forall(x points isLocation(x))
            ycError("arguments #1 is not a valid point list - %A" points)
        )
        when(sides && length(points) != sides
            return()
        )
        lengthList = foreach(mapcar (a b) points cdr(points)
            end = a
            ycGetLineLength(list(a b))
        )
        lengthList = cons(ycGetLineLength(list(end car(points))) lengthList)
        maxLen = apply('max lengthList)
        minLen = apply('min lengthList)
        when((1 - minLen/maxLen) < ratio
            return(t)
        )
    )
); ycIsPolygonEquilateral

; END
