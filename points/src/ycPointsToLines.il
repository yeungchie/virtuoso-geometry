;--------------------------
; Program  : virtuoso-geometry(points/ycPointsToLines.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 拆分点列表为线列表
; ycPointsToLines(list(0:0 1:0 1:1 0:1))
; ( (( 0 0 ) ( 1 0 ))
;   (( 1 0 ) ( 1 1 ))
;   (( 1 1 ) ( 0 1 )) 
;   (( 0 1 ) ( 0 0 )) )

procedure(ycPointsToLines(polygon \@optional open "lg")
    unless(forall(x polygon isLocation(x))
        ycError("argument #1 should be a point list - %A" polygon)
    )
    case(length(polygon)
        (1
            ycError("not a valid polygon - %A" polygon)
        )
        (2
            list(polygon)
        )
        (t
            foreach(mapcar (p1 p2)
                polygon
                if(open
                    cdr(polygon)
                    append1(cdr(polygon) car(polygon))
                )
                list(p1 p2)
            )
        )
    )
); ycPointsToLines

; END
