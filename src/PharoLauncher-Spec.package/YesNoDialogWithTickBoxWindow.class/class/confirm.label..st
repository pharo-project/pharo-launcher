ui requests
confirm: description label: title
	^ (UIManager default modalMorph openModal: (
		(self newWithTheme: Smalltalk ui theme)
			textFont: Smalltalk ui theme textFont;
			title: title;
			text: description)) answer