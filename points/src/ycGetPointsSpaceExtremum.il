;--------------------------
; Program  : virtuoso-geometry(points/ycGetPointsSpaceExtremum.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取一堆点的间距的极值

procedure(ycGetPointsSpaceExtremum(func points \@optional findLocation "slg")
    prog((i space info)
        unless(member(func list('min 'max))
            ycError("argument #1 is not a valid value - %A" func)
        )
        unless(points
            ycWarn("argument #2 is empty - %A" points)
            return()
        )
        unless(forall(p points isLocation(p))
            ycError("argument #2 is not a valid point list - %A" points)
        )
        i = 0
        foreach(p1 points
            i++
            foreach(p2 nthcdr(i points)
                let((lineLength)
                    lineLength = ycGetLineLength(list(p1 p2))
                    if(space
                    then
                        case(func
                            (min
                                when(lineLength < space
                                    space = lineLength
                                    when(findLocation
                                        info = list(p1 p2)
                                    )
                                )
                            )
                            (max
                                when(lineLength > space
                                    space = lineLength
                                    when(findLocation
                                        info = list(p1 p2)
                                    )
                                )
                            )
                        )
                    else
                        space = lineLength
                        info = list(p1 p2)
                    )
                )
            )
        )
        return(if(findLocation
            list(space info)
            space
        ))
    )
); ycGetPointsSpaceExtremum

; END
