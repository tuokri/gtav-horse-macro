#include <Array.au3>
#include <AutoItConstants.au3>
#include <Misc.au3>

Global $handle_user32 = DllOpen("user32.dll")

; Default values assume 1920x1080 display.
Global $mpos_place_bet_0[2] = [1596, 909] ; Place bet button location in main menu.
Global $mpos_horse[2] = [388, 345] ; Horse #1 button location by default.
Global $mpos_place_bet_1[2] = [1522, 795] ; Place bet button location in the betting menu.
Global $mpos_inc_bet[2] = [1528, 520] ; Increase bet arrow button location.
Global $mpos_bet_again[2] = [1042, 1003] ; Bet again button location.

Global $t_race = 35 * 1000 ; Race duration + safety margin.

Global $t_bet_count = 12 ; Betting stops at 2000 (bet arrow click count)

; Variable duration of holding left click after clicking the increase bet arrow.
Global $t_hold_click_min = Int($t_race / 4)
Global $t_hold_click_max = Int($t_race / 2)

; Record button locations hotkey (alt + c).
HotKeySet("!c", "RecordButtonLocations")

; End script hotkey (alt + b).
HotKeySet("!b", "Quit")

; Wait for alt + a keystroke.
HotKeySet("!a", "Main")
While True
	Sleep(100)
WEnd

Func Main()
	; Disable hotkeys once in Main function.
	HotKeySet("!a")
	HotKeySet("!c")

	; Loop until Quit() is called (alt + b).
	While True
		; Randomize coordinate variation and delays per every loop.
		Local $random_click_sleep = Random(35, 45, 1)
		Local $random_sleep = Random(15, 35, 1)
		Local $random_variance = Random(-2, 2, 1)
		Local $random_hold_click = Random($t_hold_click_min, $t_hold_click_max, 1)

		Local $m_pb_0_x = $mpos_place_bet_0[0] + $random_variance
		Local $m_pb_0_y = $mpos_place_bet_0[1] + $random_variance
		Local $m_pb_1_x = $mpos_place_bet_1[0] + $random_variance
		Local $m_pb_1_y = $mpos_place_bet_1[1] + $random_variance
		Local $m_horse_x = $mpos_horse[0] + $random_variance
		Local $m_horse_y = $mpos_horse[1] + $random_variance
		Local $m_inc_b_x = $mpos_inc_bet[0] + $random_variance
		Local $m_inc_b_y = $mpos_inc_bet[1] + $random_variance
		Local $m_bet_again_x = $mpos_bet_again[0] + $random_variance
		Local $m_bet_again_y = $mpos_bet_again[1] + $random_variance

		; Place bet button #1.
		MouseMove($m_pb_0_x, $m_pb_0_y)
		DelayClick($random_click_sleep)
		Sleep($random_sleep * 2)

		; Choose horse button.
		MouseMove($m_horse_x, $m_horse_y)
		DelayClick($random_click_sleep)
		Sleep($random_sleep * 2)

		; Increase bet arrow button.
		Local $bet_count = 1
		Local $random_bet_sleep = Random(50, 2500, 1)
		MouseMove($m_inc_b_x, $m_inc_b_y)
		While $bet_count < $t_bet_count
		   Sleep(Random(200, 1000, 1))
		   MouseDown($MOUSE_CLICK_PRIMARY)
		   Sleep(100)
		   MouseUp($MOUSE_CLICK_PRIMARY)
		   $bet_count = $bet_count + 1
		WEnd
		Sleep($random_sleep)
		MouseDown($MOUSE_CLICK_PRIMARY)

		; Place bet button #2.
		MouseMove($m_pb_1_x, $m_pb_1_y, 3)
		Sleep($random_hold_click)
		MouseUp($MOUSE_CLICK_PRIMARY)
		Sleep($t_race - $random_hold_click)

		; Bet again button.
		MouseMove($m_bet_again_x, $m_bet_again_y)
		DelayClick($random_click_sleep)
		Sleep($random_sleep)
	WEnd
EndFunc

Func DelayClick($delay)
	MouseDown($MOUSE_CLICK_PRIMARY)
	Sleep($delay)
	MouseUp($MOUSE_CLICK_PRIMARY)
EndFunc

; Record button locations.
Func RecordButtonLocations()
	; Disable hotkeys while recording.
	HotKeySet("!a")
	HotKeySet("!c")

	Global $mpos_place_bet_0 = RecordButtonLocation()
	Global $mpos_horse = RecordButtonLocation()
	Global $mpos_inc_bet = RecordButtonLocation()
	Global $mpos_place_bet_1 = RecordButtonLocation()
	Global $mpos_bet_again = RecordButtonLocation()

	; Show the selected coordinates in a message box.
	MsgBox($MB_TOPMOST, "Clicked Coordinates", "Clicked: " & _ArrayToString($mpos_place_bet_0) _
           & ", " & _ArrayToString($mpos_horse) & ", " & _ArrayToString($mpos_place_bet_1) _
		   & ", " & _ArrayToString($mpos_inc_bet) & ", " & _ArrayToString($mpos_bet_again))

	; Re-enable hotkeys.
	HotKeySet("!a", "Main")
	HotKeySet("!c", "RecordButtonLocations")
EndFunc

; Wait for MMB to be pressed and record location.
Func RecordButtonLocation()
	While True
		If _IsPressed(04, $handle_user32) Then
			Local $mpos = MouseGetPos()
			Beep(1500, 250)
			; Wait until key is no longer pressed.
			While _IsPressed(04, $handle_user32) <> 0
				Sleep(50)
			WEnd
			ExitLoop
		Endif
		Sleep(50);
	WEnd
	Return $mpos
EndFunc

Func Quit()
	DllClose($handle_user32)
	Exit 0
EndFunc
