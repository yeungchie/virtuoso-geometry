;--------------------------
; Program  : virtuoso-geometry(points/ycGetFigPoints.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGetFigPoints(fig "d")
    case(fig~>objType
        (("inst" "mosaic")
            ycBBoxToPoints(fig~>bBox)
        )
        ("rect"
            ycBBoxToPoints(fig~>bBox)
        )
        (("polygon" "PRBoundary" "areaBoundary" "snapBoundary")
            fig~>points
        )
        ("path"
            dbGetPathBoundary(fig)
        )
        ("pathSeg"
            fig~>boundary
        )
    )
)

; END