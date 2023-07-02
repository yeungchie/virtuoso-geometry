;--------------------------
; Program  : virtuoso-geometry(line/ycGetLineByCoefK.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

procedure(ycGetLineByCoefK(\@key k origin(0:0) length(1) "nln")
    let((x y point)
        unless(isLocation(origin)
            ycError("argument for key ?origin should be a location - %A" origin)
        )
        k *= 1.0
        origin = foreach(mapcar x origin x *= 1.0)
        length *= 1.0

        cond(
            (isInfinity(k)
                x = 0
                y = length
            )
            (abs(k) < 1e-10
                x = length
                y = 0
            )
            (t
                x = sqrt(length**2 / ( 1 + k**2 ))
                y = x*k
                when(length < 0
                    x *= -1.0
                )
            )
        )
        point = rodAddPoints(x:y origin)
        list(origin point)
    )
); ycGetLineByCoefK

; END
