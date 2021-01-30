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
; > Transpose Esc and CapsLock
CapsLock::Esc
Esc::CapsLock

; ---------------------------------------------------------------------------
;  Direction Related
; ---------------------------------------------------------------------------
; ← ↓ ↑ →
<!h::Send {Left}
<!j::Send {Down}
<!k::Send {Up}
<!l::Send {Right}

; Windows Desktop
<!<^.::Send #^{Right}
<!<^,::Send #^{Left}

; Other hot keys
<!.:: Send ^{PgDn}
<!,:: Send ^{PgUp}

; ---------------------------------------------------------------------------
;  Text Editor 
; ---------------------------------------------------------------------------
; Delete backward
<^h::Send {Backspace}
; Select left/right
<!<+h::Send +{Left}
<!<+l::Send +{Right}
; Jump forward/backward a word
<!b::Send ^{Left}
<!f::Send ^{Right}
; Select forward/backward a word
<!<+b::Send ^+{Left}
<!<+f::Send ^+{Right}
; Jump to line beginning/end
<!a::Send {Home}
<!e::Send {End}

; Select to line beginning/end
<!<+a::Send +{Home}
<!<+e::Send +{End}
; Select from cursor to line above/below
<!<+j::Send {Shift Down}{Down}{Shift Up}
<!<+k::Send {Shift Down}{Up}{Shift Up}

; Delete backward word
<^<+h::Send {Control Down}{Backspace}{Control Up}
; Open a new line below/above
<!o::Send {End}{Enter}
<+<!o::Send {Up}{End}{Enter}
; Delete this line
!d::Send {Home}{Shift Down}{End}{Shift Up}{Backspace}
; Delete all after the cursor in this line  
!c::Send {Shift Down}{End}{Shift Up}{Backspace}

; ---------------------------------------------------------------------------
;  App Hotkeys
; ---------------------------------------------------------------------------
>!a::WinXOR("Adobe Acrobat Pro DC")
>!c::WinXOR("Google Chrome")
>!d::WinXOR("Docear")
>!p::WinXOR("\.py$")
>!<+p::WinXOR("PowerPoint")
>!o::WinXOR("OneNote")	 
>!v::WinXOR("GVIM")

; ---------------------------------------------------------------------------
;  CTRL+SHIFT+ALT Combinations
; ---------------------------------------------------------------------------

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
  if (cmd == "wmo")
    Run python E:\rnn_club\view_notes.py
    ;Run Cmd /K "python E:\rnn_club\view_notes.py t"
  return

  ; For unknown command 
  MsgBox, Unknown command "%cmd%"
return

; =============================================================================
;  Mouse Simulation 
; =============================================================================
<^<!h::MouseMove, -50, 0, 5, R
<^<!+h::MouseMove, -400, 0, 5, R
<^<!l::MouseMove, 50, 0, 5, R
<^<!+l::MouseMove, 400, 0, 5, R
<^<!j::MouseMove, 0, 50, 5, R
<^<!+j::MouseMove, 0, 300, 5, R
<^<!k::MouseMove, 0, -50, 5, R
<^<!+k::MouseMove, 0, -300, 5, R
<!n::MouseClick, WheelDown, , , 2, 0, D, R
<!p::MouseClick, WheelUp, , , 2, 0, D, R
<^<!Enter::MouseClick, Left

