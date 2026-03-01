CoordMode, Mouse, Screen
#MaxHotkeysPerInterval 400

; ! - alt
; + - shift
; ^ - ctrl

; switch tabs
!o::Send ^+{Tab 1}
!p::Send ^{Tab 1}

; home and end
!+j::Send {Home 1}
!+l::Send {End 1}

; browser functions
!^o::Send {Browser_Back 1}
!^p::Send {Browser_Forward 1}

; page down and page up 
!^i::Send {PgUp 1}
!^k::Send {PgDn 1}

; ctrl home and end
!+i::Send ^{Home 1}
!+k::Send ^{End 1}

; traverse by word
!^l::Send ^{Right 1}
!^j::Send ^{Left 1}

; highlight words / lines
!^+l::Send ^+{Right 1}
!^+j::Send ^+{Left 1}
!^+i::Send ^+{Up 1}
!^+k::Send ^+{Down 1}

; newline commands
;  newline below
!Enter::Send {End 1}{Enter 1}
;  newline above
!+Enter::Send {Up 1}{End 1}{Enter 1}

!Space::Send {End 1}{Space 1}
!+Space::Send {Home 1}{Space 1}{Left 1}

; Block LMB when alt is pressed
!LButton::return

; alt jkli simple movements
!j::SendInput {Left 1}
!k::SendInput {Down 1}
!i::SendInput {Up 1}
!l::SendInput {Right 1}

; Window always on top
!+^n:: Winset, Alwaysontop, , A
