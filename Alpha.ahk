; Transpose Esc and CapsLock
CapsLock::Esc
Esc::CapsLock

; Google Search Shortcut
!s::Send ^l{Tab}{Tab}{Tab}{Tab}{Tab}{Tab}

; Emacs
;!^f::Send {Right}
!f::Send ^{Right}
;!^b::Send {Left}
!b::Send ^{Left}
;^n::Send {Down}
;^p::Send {Up}
!a::Send {Home}
!e::Send {End}

; Other hot keys
^h::Send {Backspace}
^+h::Send {Control Down}{Backspace}{Control Up}
!+h::Send !{Left}
;^l::Send {Delete}
^+l::Send ^{Delete}
!+l::Send !{Right}
^;::Send {Enter}
!h::Send {Left}
!l::Send {Right}
!j::Send {Down}
!+j::Send {Shift Down}{Down}{Shift Up}
!k::Send {Up}
!+k::Send {Shift Down}{Up}{Shift Up}
!o::Send {End}{Enter}
+!o::Send {Up}{End}{Enter}
!d::Send {Home}{Shift Down}{End}{Shift Up}{Backspace}
!c::Send {Shift Down}{End}{Shift Up}{Backspace}
+!f::Send {Ctrl Down}{Shift Down}{Right}{Ctrl Up}{Shift Up}
+!b::Send {Ctrl Down}{Shift Down}{Left}{Ctrl Up}{Shift Up}
+!e::Send {Shift Down}{End}{Shift Up}
!.:: Send {Ctrl Down}{PgDn}{Ctrl Up}
!,:: Send {Ctrl Down}{PgUp}{Ctrl Up}

; Deprecated
;!u::Send {Ctrl Down}{Left}{Ctrl Up}
;!i::Send {Ctrl Down}{Right}{Ctrl Up}
;!y::Send {Home}
;!o::Send {End}

; Mouse Simulation
^!h:: 
    MouseMove, -50, 0, 5, R
Return

^!+h:: 
    MouseMove, -400, 0, 5, R
Return

^!l::
    MouseMove, 50, 0, 5, R
Return

^!+l::
    MouseMove, 400, 0, 5, R
Return

^!j::
    MouseMove, 0, 50, 5, R
Return

^!+j::
    MouseMove, 0, 300, 5, R
Return

^!k::
    MouseMove, 0, -50, 5, R
Return

^!+k::
    MouseMove, 0, -300, 5, R
Return

^!;::
    MouseClick, Left
Return

!n::
    MouseClick, WheelDown, , , 2, 0, D, R
Return

!p::
    MouseClick, WheelUp, , , 2, 0, D, R
Return


; Complicated commands
^+!e::
    MsgBox, 36, Edit script, Press [Yes] to edit current autohotkey script 
    IfMsgBox Yes
        Edit
Return

^+!r::
    MsgBox, 36, Reload script, Press [Yes] to reload current autohotkey script 
    IfMsgBox Yes
        MsgBox, 64, Script reloaded, Current script reloaded successfully
        Reload
Return

^+!;::
    MsgBox, 36, Edit logs, Press [Yes] to edit logs
    IfMsgBox Yes
        Run C:\Users\HPEC\Dropbox\Docs\Logs.xml
Return

^+!1::
    Run C:\Users\HPEC\Dropbox\Docs\ASCII.jpg
Return
