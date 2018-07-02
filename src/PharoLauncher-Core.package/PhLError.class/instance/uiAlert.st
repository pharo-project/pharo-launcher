ui
uiAlert
	UIManager default
		alert: self longDescription
		title: self name
		configure: [ :morph | (morph findDeeplyA: TextMorph) unlock ]