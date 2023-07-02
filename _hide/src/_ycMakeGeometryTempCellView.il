;--------------------------
; Program  : virtuoso-geometry(_hide/_ycMakeGeometryTempCellView.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(_ycMakeGeometryTempCellView()
    prog((cvId)
        when(cvId = car(dbGetOpenCellViews())
            return(cvId)
        )
        foreach(lib ddGetLibList()
            foreach(cell lib~>cells
                foreach(view cell~>views
                    when(cvId = dbOpenCellViewByType(lib cell~>name view~>name nil "r")
                        return(cvId)
                    )
                )
            )
        )
    )
); _ycMakeGeometryTempCellView

; END
