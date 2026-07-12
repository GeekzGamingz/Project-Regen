extends Window
#------------------------------------------------------------------------------#
func _notification(event):
	if event == NOTIFICATION_WM_SIZE_CHANGED: Cursor.resize_cursor(Cursor.current_cursor)
