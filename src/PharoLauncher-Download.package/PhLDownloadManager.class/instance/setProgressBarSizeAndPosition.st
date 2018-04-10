action
setProgressBarSizeAndPosition
	"increase size and reposition progress bar to the middle of screen to make it more visible"
	SystemProgressMorph uniqueInstance
		minWidth: 600;
		minHeight: 50;
		layoutInset: 30 @ 20;
		position: 150 @ 200	