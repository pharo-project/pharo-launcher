private
dontNotifyDuring: aBlock
	| wantNotificationBackup |
	[ 
	wantNotificationBackup := wantNotification.
	wantNotification := false.
	aBlock value ]
		ensure: [ wantNotification := wantNotificationBackup ]