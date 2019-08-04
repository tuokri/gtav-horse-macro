#include <AutoItConstants.au3>

; Assuming 1920x1080 display.
Global $mpos_place_bet_0[2] = [1596, 909] ; Place bet button location in main menu.
Global $mpos_horse_1[2] = [388, 345] ; Horse #1 button location.
Global $mpos_place_bet_1[2] = [1522, 795] ; Place bet button location in the betting menu.
Global $mpos_inc_bet[2] = [1528, 520] ; Increase bet arrow button location.
Global $mpos_bet_again[2] = [1042, 1003] ; Bet again button location.

Global $t_race = 35 * 1000; Race duration + safety margin.
Global $t_hold_click_min = Int($t_race / 4)
Global $t_hold_click_max = Int($t_race / 2)

; End script hotkey (alt + b).
HotKeySet("!b", "Quit")

; Wait for alt + a keystroke.
HotKeySet("!a", "Main")
While True
	Sleep(100)
WEnd

Func Main()
	HotKeySet("!a") ; Disable hotkey once in Main function.

	Local $random_click_sleep
	Local $random_sleep
	Local $random_variance
	Local $random_hold_click
	Local $m_pb_0_x
	Local $m_pb_0_y
	Local $m_pb_1_x
	Local $m_pb_1_y
	Local $m_horse_x
	Local $m_horse_y
	Local $m_inc_b_x
	Local $m_inc_b_y
	Local $m_bet_again_x
	Local $m_bet_again_y

	While True
		$random_click_sleep = Random(35, 45, 1)
		$random_sleep = Random(15, 35, 1)
		$random_variance = Random(-2, 2, 1)
		$random_hold_click = Random($t_hold_click_min, $t_hold_click_max, 1)

		$m_pb_0_x = $mpos_place_bet_0[0] + $random_variance
		$m_pb_0_y = $mpos_place_bet_0[1] + $random_variance
		$m_pb_1_x = $mpos_place_bet_1[0] + $random_variance
		$m_pb_1_y = $mpos_place_bet_1[1] + $random_variance
		$m_horse_x = $mpos_horse_1[0] + $random_variance
		$m_horse_y = $mpos_horse_1[1] + $random_variance
		$m_inc_b_x = $mpos_inc_bet[0] + $random_variance
		$m_inc_b_y = $mpos_inc_bet[1] + $random_variance
		$m_bet_again_x = $mpos_bet_again[0] + $random_variance
		$m_bet_again_y = $mpos_bet_again[1] + $random_variance

		MouseMove($m_pb_0_x, $m_pb_0_y)
		MouseDown($MOUSE_CLICK_PRIMARY)
		Sleep($random_click_sleep)
		MouseUp($MOUSE_CLICK_PRIMARY)
		Sleep($random_sleep * 2)

		MouseMove($m_horse_x, $m_horse_y)
		MouseDown($MOUSE_CLICK_PRIMARY)
		Sleep($random_click_sleep)
		MouseUp($MOUSE_CLICK_PRIMARY)
		Sleep($random_sleep * 2)

		MouseMove($m_pb_1_x, $m_pb_1_y)
		MouseDown($MOUSE_CLICK_PRIMARY)
		Sleep($random_click_sleep)
		MouseUp($MOUSE_CLICK_PRIMARY)
		Sleep($random_sleep * 2)

		MouseMove($m_inc_b_x, $m_inc_b_y, 3)
		Sleep($random_sleep)
		MouseDown($MOUSE_CLICK_PRIMARY)
		Sleep($random_hold_click)
		MouseUp($MOUSE_CLICK_PRIMARY)
		Sleep($t_race - $random_hold_click)
		Sleep($random_sleep * 5)

		MouseMove($m_bet_again_x, $m_bet_again_y)
		MouseDown($MOUSE_CLICK_PRIMARY)
		Sleep($random_click_sleep)
		MouseUp($MOUSE_CLICK_PRIMARY)
		Sleep($random_sleep)
	WEnd
EndFunc

Func Quit()
	Exit 0
EndFunc
