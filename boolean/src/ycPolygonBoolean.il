;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonBoolean.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 多边形的布尔运算

procedure(ycPolygonBoolean(operation polygon1 foo \@key cvId(_ycMakeGeometryTempCellView()) "Slgd")
    prog((operationList polygonList)

        when(stringp(operation)
            operation = stringToSymbol(operation)
        )
        operationList = '(and not or xor size)
        unless(member(operation operationList)
            ycError("argument for keyword ?operation should be one of the %A - %A" operationList operation)
        )

        ; polygon1
        when(length(polygon1) < 3
            ycError("argument #1 should be a point list for polygon - %A" polygon1)
        )
        unless(forall(x polygon1 isLocation(x))
            ycError("argument #1 is not a valid point list - %A" polygon1)
        )

        ; cvId
        unless(dbIsId(cvId) && cvId~>objType == "cellView"
            ycError("argument for keyword ?cvId should be a database object of cellView - %A" cvId)
        )

        ; operation
        polygonList = case(operation
            ((and not or xor)
                ; polygon2
                when(length(foo) < 3
                    ycError("argument #2 should be a point list for polygon - %A" foo)
                )
                unless(forall(x foo isLocation(x))
                    ycError("argument #2 is not a valid point list - %A" foo)
                )
                case(operation
                    (and       dbPointArrayAnd(cvId list(polygon1) list(foo)))
                    (not    dbPointArrayAndNot(cvId list(polygon1) list(foo)))
                    (or         dbPointArrayOr(cvId list(polygon1) list(foo)))
                    (xor       dbPointArrayXor(cvId list(polygon1) list(foo)))
                )
            )
            ("size"
                ; size
                unless(numberp(foo)
                    ycError("argument #2 should be an number - %A" foo)
                )
                dbPointArraySize(cvId list(polygon1) list(foo))
            )
        )

        return(polygonList)
    )
); ycPolygonBoolean

; END
