;--------------------------
; Program  : virtuoso-geometry(points/ycGetInscribedBBox.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 获取四边形的内切矩形，其实并不是[内切]，找不到合适的词
; ycGetInscribedBBox(list(0:0 2:0 3:1 1:1))
; ( ( 1 1 )
;   ( 2 1 ) )

procedure(ycGetInscribedBBox(polygon \@key cvId "lg")
    prog((xList yList xMin2 yMin2 xMax2 yMax2 bBox)
        unless(length(polygon) == 4
            ycError("argument #1 should be points for quadrilateral polygon - %A" polygon)
        )
        foreach(p polygon
            unless(isLocation(p)
                ycError("argument #1 not a valid point list - %A" polygon)
            )
            xList = cons(1.0*xCoord(p) xList)
            yList = cons(1.0*yCoord(p) yList)
        )
        when(cvId && !(dbIsId(cvId) && cvId~>objType == "cellView")
            ycError("argument for keyword ?cvId should be a database object of cellView - %A" cvId)
        )

        xList = sort(copy(xList) 'lessp)
        yList = sort(copy(yList) 'lessp)

        xMin2 = cadr(xList)
        yMin2 = cadr(yList)

        xMax2 = cadr(reverse(xList))
        yMax2 = cadr(reverse(yList))

        bBox = list(xMin2:yMin2 xMax2:yMax2)

        cvId = cvId || ycGenTempCellView()

        unless(ycIsValidBBox(bBox)
            return()
        )

        when(dbPointArrayAndNot(cvId list(ycBBoxToPoints(bBox)) list(polygon))
            polygon = car(dbPointArrayAnd(cvId list(ycBBoxToPoints(bBox)) list(polygon)))
            unless(length(polygon) == 4
                return()
            )
            bBox = ycGetInscribedBBox(polygon ?cvId cvId)
        )

        return(bBox)
    )
); ycGetInscribedBBox
; END
