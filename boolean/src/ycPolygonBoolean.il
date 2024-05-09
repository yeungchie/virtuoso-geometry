;--------------------------
; Program  : virtuoso-geometry(boolean/ycPolygonBoolean.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 多边形的布尔运算

procedure(ycPolygonBoolean(operation polygon1 foo \@key cvId(_ycMakeGeometryTempCellView()) precision(10000.0) "Slgdn")
    let((operationList function precisionBackup polygonList errorp)
        when(stringp(operation)
            operation = stringToSymbol(operation)
        )
        operationList = '(and not or xor size)
        unless(memq(operation operationList)
            ycError("argument #3 should be one of the %A - %A" operationList operation)
        )

        ; polygon1
        cond(
            (!polygon1
                t
            )
            (forall(x polygon1 isLocation(x))
                polygon1 = list(polygon1)   ; 单个多边形
            )
            (forall(polygon polygon1 forall(x polygon isLocation(x)))
                t   ; 多边形列表
            )
            (t
                ycError("argument #1 should be either a list of point or a list of points - %A" polygon1)
            )
        )
        foreach(x polygon1
            when(length(x) < 3
                ycError("argument #1 should be a point list for polygon - %A" polygon1)
            )
        )

        ; cvId
        unless(dbIsId(cvId) && cvId~>objType == "cellView"
            ycError("argument for keyword ?cvId should be a database object of cellView - %A" cvId)
        )

        ; operation
        function = caseq(operation
            ((and not or xor)
                ; polygon2
                cond(
                    (!foo
                        t
                    )
                    (forall(x foo isLocation(x))
                        foo = list(foo)   ; 单个多边形
                    )
                    (forall(polygon foo forall(x polygon isLocation(x)))
                        t   ; 多边形列表
                    )
                    (t
                        ycError("argument #2 should be either a list of point or a list of points - %A" foo)
                    )
                )
                foreach(x foo
                    when(length(x) < 3
                        ycError("argument #2 should be a point list for polygon - %A" foo)
                    )
                )
                caseq(operation
                    (and    'dbPointArrayAnd    )
                    (not    'dbPointArrayAndNot )
                    (or     'dbPointArrayOr     )
                    (xor    'dbPointArrayXor    )
                )
            )
            (size
                ; size
                unless(numberp(foo)
                    ycError("argument #2 should be an number - %A" foo)
                )
                'dbPointArraySize
            )
        )

        ; 调整精度
        unless(nearlyEqual(cvId~>DBUPerUU precision)
            precisionBackup = cvId~>DBUPerUU
            cvId~>DBUPerUU = 1.0*precision
        )

        errset(
            polygonList = funcall(function cvId polygon1 foo)
            t
        )
        errorp = errset.errset

        ; 恢复精度
        when(precisionBackup
            cvId~>DBUPerUU = precisionBackup
        )

        when(errorp
            ycError("something error happened ...")
        )

        polygonList
    )
); ycPolygonBoolean

; END
