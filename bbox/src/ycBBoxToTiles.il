;--------------------------
; Program  : virtuoso-geometry(bbox/ycBBoxToTiles.il)
; Language : Cadence Skill
; Author   : YEUNGCHIE
;--------------------------

; 将大的 bBox 切成一堆小块的 tiles，并按照不同象限分组

procedure(ycBBoxToTiles(bBox \@key size(100) origin(0:0) flatten(t) "lnlg")
    prog((left right top bottom originX originY quad1 quad2 quad3 quad4 tileList)
        when((size < 0) || nearlyEqual(size 0)
            ycWarn("size must greater then 0 - %A" size)
            return(list(bBox))
        )
        unless(isBBox(bBox)
            ycError("invalid bBox - %A" bBox)
        )
        unless(isLocation(origin)
            ycError("invalid origin - %A" origin)
        )
        ycBBoxAssign(ycBBox(bBox) 'left 'bottom 'right 'top)
        when(nearlyEqual(left right) || nearlyEqual(top bottom)
            return()
        )
        originX = xCoord(origin)
        originY = yCoord(origin)
        size   *= 1.0
        
        when((originX < right) && (originY < top) && !nearlyEqual(originX right) && !nearlyEqual(originY top)
            let((x1(originX) x2(originX))
                while(x1 < right && !nearlyEqual(x1 right)      ; x1 在 Box 左侧
                    x2 += size
                    when(x1 < left && !nearlyEqual(x1 left)     ; x1 贴近 Box 左边缘
                        x1 = left
                        while(x2 < x1 || nearlyEqual(x2 x1)     ; x2 在 x1 右侧
                            x2 += size
                        )
                    )
                    when(x2 > right || nearlyEqual(x2 right)    ; x2 贴近 Box 右边缘
                        x2 = right
                    )
                    let((y1(originY) y2(originY))
                        while(y1 < top && !nearlyEqual(y1 top)          ; y1 在 Box 下侧
                            y2 += size
                            when(y1 < bottom && !nearlyEqual(y1 bottom) ; y1 贴近 Box 下边缘
                                y1 = bottom
                                while(y2 < y1 || nearlyEqual(y2 y1)     ; y2 在 y1 上侧
                                    y2 += size
                                )
                            )
                            when(y2 > top || nearlyEqual(y2 top)        ; y2 贴近 Box 上边缘
                                y2 = top
                            )
                            quad1 = cons(list(x1:y1 x2:y2) quad1)       ; 输出 Tile
                            y1 = y2 ; y1 进位
                        )
                    )
                    x1 = x2 ; x1 进位
                )
            )
        ); quadrant 1
        
        when((originX > left) && (originY < top) && !nearlyEqual(originX left) && !nearlyEqual(originY top)
            let((x1(originX) x2(originX))
                while(x1 > left && !nearlyEqual(x1 left)        ; x1 在 Box 右侧
                    x2 -= size
                    when(x1 > right && !nearlyEqual(x1 right)   ; x1 贴近 Box 右边缘
                        x1 = right
                        while(x2 > x1 || nearlyEqual(x2 x1)     ; x2 在 x1 左侧
                            x2 -= size
                        )
                    )
                    when(x2 < left || nearlyEqual(x2 left)      ; x2 贴近 Box 左边缘
                        x2 = left
                    )
                    let((y1(originY) y2(originY))
                        while(y1 < top && !nearlyEqual(y1 top)          ; y1 在 Box 下侧
                            y2 += size
                            when(y1 < bottom && !nearlyEqual(y1 bottom) ; y1 贴近 Box 下边缘
                                y1 = bottom
                                while(y2 < y1 || nearlyEqual(y2 y1)     ; y2 在 y1 上侧
                                    y2 += size
                                )
                            )
                            when(y2 > top || nearlyEqual(y2 top)        ; y2 贴近 Box 上边缘
                                y2 = top
                            )
                            quad2 = cons(list(x2:y1 x1:y2) quad2)       ; 输出 Tile
                            y1 = y2 ; y1 进位
                        )
                    )
                    x1 = x2 ; x1 进位
                )
            )
        ); quadrant 2

        when((originX > left) && (originY > bottom) && !nearlyEqual(originX left) && !nearlyEqual(originY bottom)
            let((x1(originX) x2(originX))
                while(x1 > left && !nearlyEqual(x1 left)        ; x1 在 Box 右侧
                    x2 -= size
                    when(x1 > right && !nearlyEqual(x1 right)   ; x1 贴近 Box 右边缘
                        x1 = right
                        while(x2 > x1 || nearlyEqual(x2 x1)     ; x2 在 x1 左侧
                            x2 -= size
                        )
                    )
                    when(x2 < left || nearlyEqual(x2 left)      ; x2 贴近 Box 左边缘
                        x2 = left
                    )
                    let((y1(originY) y2(originY))
                        while(y1 > bottom && !nearlyEqual(y1 bottom)    ; y1 在 Box 上侧
                            y2 -= size
                            when(y1 > top && !nearlyEqual(y1 top)       ; y1 贴近 Box 上边缘
                                y1 = top
                                while(y2 > y1 || nearlyEqual(y2 y1)     ; y2 在 y1 下侧
                                    y2 -= size
                                )
                            )
                            when(y2 < bottom || nearlyEqual(y2 bottom)  ; y2 贴近 Box 下边缘
                                y2 = bottom
                            )
                            quad3 = cons(list(x2:y2 x1:y1) quad3)       ; 输出 Tile
                            y1 = y2 ; y1 进位
                        )
                    )
                    x1 = x2
                )
            )
        ); quadrant 3

        when((originX < right) && (originY > bottom) && !nearlyEqual(originX right) && !nearlyEqual(originY bottom)
            let((x1(originX) x2(originX))
                while(x1 < right && !nearlyEqual(x1 right)      ; x1 在 Box 左侧
                    x2 += size
                    when(x1 < left && !nearlyEqual(x1 left)     ; x1 贴近 Box 左边缘
                        x1 = left
                        while(x2 < x1 || nearlyEqual(x2 x1)     ; x2 在 x1 右侧
                            x2 += size
                        )
                    )
                    when(x2 > right || nearlyEqual(x2 right)    ; x2 贴近 Box 右边缘
                        x2 = right
                    )
                    let((y1(originY) y2(originY))
                        while(y1 > bottom && !nearlyEqual(y1 bottom)    ; y1 在 Box 上侧
                            y2 -= size
                            when(y1 > top && !nearlyEqual(y1 top)       ; y1 贴近 Box 上边缘
                                y1 = top
                                while(y2 > y1 || nearlyEqual(y2 y1)     ; y2 在 y1 下侧
                                    y2 -= size
                                )
                            )
                            when(y2 < bottom || nearlyEqual(y2 bottom)  ; y2 贴近 Box 下边缘
                                y2 = bottom
                            )
                            quad4 = cons(list(x1:y2 x2:y1) quad4)       ; 输出 Tile
                            y1 = y2 ; y1 进位
                        )
                    )
                    x1 = x2 ; x1 进位
                )
            )
        ); quadrant 4

        foreach(x list(quad1 quad2 quad3 quad4)
            tileList = apply(flatten && 'append || 'append1 list(tileList x))
        )
        return(tileList)
    )
); ycBBoxToTiles

; END
