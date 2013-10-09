action
displayProgress: label during: workBlock
	UIManager default informUserDuring:
	[	:bar1|
		bar1 label: label.
		UIManager default informUserDuring:
		[	:bar2|
			[workBlock value] on: HTTPProgress do: 
			[	: progress |
				bar2 label: progress printString. 	
				progress resume.
			].
		].
	].
	