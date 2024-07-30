;--------------------------
; Program  : virtuoso-geometry(point/ycIsPointInsidePolygon.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycIsPointInsidePolygon(point polygon \@optional ignoreTouch "llg")
    unless(isLocation(point)
        ycError("argument #1 should be a point - %A" point)
    )
    unless((length(polygon) > 2) && forall(x polygon isLocation(x))
        ycError("argument #2 should be a polygon - %A" polygon)
    )
    prog((pX left seg count junction)
        pX = xCoord(point)
        left = leftEdge(ycPointToBBox(polygon))
        when(nearlyEqual(pX left)
            left -= 1
        )
        seg = list(point left:yCoord(point))
        count= 0
        foreach(line ycPointsToLines(polygon)
            when(junction = ycGetJunction(seg line t)
                when(nearlyEqual(pX xCoord(junction))
                    return(!ignoreTouch)
                )
                count++
            )
        )
        return(oddp(count))
    )
)

; END
