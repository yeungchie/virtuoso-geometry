;--------------------------
; Program  : virtuoso-geometry(bbox/ycBBox.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 规范化 bBox 格式，使得第一个点代表左下角顶点，第二个点代表右上角顶点

procedure(ycBBox(bBox "l")
    let((x1 y1 x2 y2)
        unless(isBBox(bBox)
            ycError("arguments #1 should be a bBox - %A" bBox)
        )
        x1 = 1.0*min(xCoord(car(bBox)) xCoord(cadr(bBox)))
        y1 = 1.0*min(yCoord(car(bBox)) yCoord(cadr(bBox)))
        x2 = 1.0*max(xCoord(car(bBox)) xCoord(cadr(bBox)))
        y2 = 1.0*max(yCoord(car(bBox)) yCoord(cadr(bBox)))
        list(x1:y1 x2:y2)
    )
)

; END
