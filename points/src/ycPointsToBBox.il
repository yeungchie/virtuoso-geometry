;--------------------------
; Program  : virtuoso-geometry(points/ycPointsToBBox.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取一堆点所占空间的 bBox
; ycPointsToBBox(list(0:0 1:0 1:1 0:1))
; ( ( 0 0 )
;   ( 1 1 ) )

procedure(ycPointsToBBox(points "l")
    let((xMin xMax yMin yMax)
        foreach(p points
            unless(isLocation(p)
                ycError("arguments #1 is not a valid point list - %A" points)
            )
            xMin = 1.0 * if(xMin min(xMin xCoord(p)) xCoord(p))
            xMax = 1.0 * if(xMax max(xMax xCoord(p)) xCoord(p))
            yMin = 1.0 * if(yMin min(yMin yCoord(p)) yCoord(p))
            yMax = 1.0 * if(yMax max(yMax yCoord(p)) yCoord(p))
        )
        if(abs(xMin-xMax) < 1e-10 || abs(yMin-yMax) < 1e-10
            nil
            list(xMin:yMin xMax:yMax)
        )
    )
); ycPointsToBBox

; END
