; =============================================================================
;  Refactored in HK 2021
; =============================================================================
; ---------------------------------------------------------------------------
;  Function Definitions
; ---------------------------------------------------------------------------
WinXOR(Tail)
{
  SetTitleMatchMode, RegEx
  Pattern = ^.*%Tail%
  IfWinActive, %Pattern%
    WinMinimize, %Pattern%
  else
    WinActivate, %Pattern%
}

; ---------------------------------------------------------------------------
;  Re-map Keys
; ---------------------------------------------------------------------------
; Transpose Esc and CapsLock
CapsLock::Esc
Esc::CapsLock
; ATTENTION: Do not set 'CapsLock & *' as this will triger unwanted CapsLock.

; ---------------------------------------------------------------------------
;  Direction Related
; ---------------------------------------------------------------------------
; ← ↓ ↑ →
<!h::Send {Left}       ; LAlt + h
<!j::Send {Down}       ; LAlt + j
<!k::Send {Up}         ; LAlt + k
<!l::Send {Right}      ; LAlt + l

; Windows Desktop
<!<^,::Send #^{Left}   ; LAlt + LCtrl + ,
<!<^.::Send #^{Right}  ; LAlt + LCtrl + .

; Other hot keys
<!.:: Send ^{PgDn}     ; LAlt + .
<!,:: Send ^{PgUp}     ; LAlt + ,

; ---------------------------------------------------------------------------
;  Text Editor 
; ---------------------------------------------------------------------------
; Delete forward/backward
<^l::Send {Delete}     ; LCtrl + l
<^h::Send {Backspace}  ; LCtrl + h
; Select left/right
<!<+h::Send +{Left}    ; LAlt + LShift + h
<!<+l::Send +{Right}   ; LAlt + LShift + l
; Jump forward/backward a word
<!b::Send ^{Left}      ; LAlt + b
<!f::Send ^{Right}     ; LAlt + f
; Select forward/backward a word
<!<+b::Send ^+{Left}   ; LAlt + LShift + b
<!<+f::Send ^+{Right}  ; LAlt + LShift + f
; Jump to line beginning/end
<!a::Send {Home}       ; LAlt + a
<!e::Send {End}        ; LAlt + e

; Select to line beginning/end
<!<+a::Send +{Home}    ; LAlt + LShift + a
<!<+e::Send +{End}     ; LAlt + LShift + e
; Select a word
<!w::Send {Control Down}{Left}{Shift Down}{Right}{Control Up}{Left}{Shift Up}  ; LAlt + w
; Select from cursor to line above/below
<!<+j::Send {Shift Down}{Down}{Shift Up}
<!<+k::Send {Shift Down}{Up}{Shift Up}

; Delete backward word
<^<+h::Send {Control Down}{Backspace}{Control Up}
; Open a new line below/above
<!o::Send {End}{Enter}
<+<!o::Send {Up}{End}{Enter}
; Delete this line
<!d::Send {Home}{Shift Down}{End}{Shift Up}{Backspace}
; Delete all after the cursor in this line  
<!c::Send {Shift Down}{End}{Shift Up}{Backspace}

; ---------------------------------------------------------------------------
;  App Hotkeys
; ---------------------------------------------------------------------------
>!a::WinXOR("Adobe Acrobat Pro DC")
>!c::WinXOR("Google Chrome")
>!d::WinXOR("Docear")
>!g::WinXOR("MINGW64:/")
>!p::WinXOR("\.py$")
>!t::WinXOR("PowerPoint")
>!o::WinXOR("OneNote")	 
>!r::WinXOR("Word")	 
>!u::WinXOR("Outlook")	 
>!v::WinXOR("GVIM")

; ---------------------------------------------------------------------------
;  CTRL+SHIFT+ALT Combinations
; ---------------------------------------------------------------------------

; ---------------------------------------------------------------------------
;  Windows Key Combinations
; ---------------------------------------------------------------------------
<#<+k::WinMaximize, A 
<#<+j::WinMinimize, A 
<#<+h::Send #{Left}
<#<+l::Send #{Right}  

; ---------------------------------------------------------------------------
;  CTRL+SHIFT+ALT+; -> Command Center
; ---------------------------------------------------------------------------
<^<!;::
  InputBox, cmd, Command Window, Please enter your command.,  , 300, 100
  if ErrorLevel
    return

  ; Select Editor
  if (cmd == "select editor" or cmd = "se") {
    FileSelectFile Editor, 2,, Select your editor, Programs (*.exe)
    if ErrorLevel
        return
    ; TODO: this line seems not working
    RegWrite, REG_SZ, HKCR\AutoHotkeyScript\Shell\Edit\Command,, "%Editor%" "`%1"
    MsgBox, "%Editor%" has been set as the default editor.
    return
  }

  ; Edit current script
  if (cmd == "edit" or cmd = "e") {
    Edit
    return
  }

  ; Reload current script
  if (cmd == "reload" or cmd = "r") {
    MsgBox, 36, Reload script, Press [Yes] to reload current autohotkey script 
    IfMsgBox Yes
      MsgBox, 64, Script reloaded, Current script reloaded successfully
      Reload
    return
  }

  ; Show active windows title
  if (cmd == "show active win title" or cmd == "awt") {
    WinGetActiveTitle, Title
    MsgBox, The active window is "%Title%".
    return
  }

  ; For private use
  if (cmd == "wmo") {
    Run python E:\lambai\view_notes.py
    ;Run Cmd /K "python E:\rnn_club\view_notes.py t"
    return
  }

  ; For unknown command 
  MsgBox, Unknown command "%cmd%"
return

; =============================================================================
;  Mouse Simulation 
; =============================================================================
<^<!h::MouseMove, -50, 0, 5, R              ; LCtrl + LAlt + h
<^<!<+h::MouseMove, -400, 0, 5, R           ; LCtrl + LAlt + LShift + h
<^<!j::MouseMove, 0, 50, 5, R               ; LCtrl + LAlt + j
<^<!<+j::MouseMove, 0, 300, 5, R            ; LCtrl + LAlt + LShift + j
<^<!k::MouseMove, 0, -50, 5, R              ; LCtrl + LAlt + k
<^<!<+k::MouseMove, 0, -300, 5, R           ; LCtrl + LAlt + LShift + k
<^<!l::MouseMove, 50, 0, 5, R               ; LCtrl + LAlt + l
<^<!<+l::MouseMove, 400, 0, 5, R            ; LCtrl + LAlt + LShift + l
<!n::MouseClick, WheelDown, , , 2, 0, D, R  ; LAlt + n
<!p::MouseClick, WheelUp, , , 2, 0, D, R    ; LAlt + p
<^<!Enter::MouseClick, Left

; =============================================================================
;  Media
; =============================================================================
<^<!<+Up::Send {Volume_Up}
<^<!<+Down::Send {Volume_Down}
<^<!<+Space::Send {Media_Play_Pause}
<^<!<+0::Send {Volume_Mute}

; =============================================================================
;  Hot Strings  #hs
; =============================================================================
;

