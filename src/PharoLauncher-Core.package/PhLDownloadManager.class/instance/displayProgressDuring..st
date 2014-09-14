private
displayProgressDuring: workBlock
	"Inform user about download progression"

  (SystemProgressMorph uniqueInstance) minWidth: 600; minHeight: 50; layoutInset: 30@20; position: 150@200. "increase size and reposition progress bar to the middle of screen to make it more visible"

	UIManager default
		informUserDuring: [ :bar | 
			workBlock
				on: HTTPProgress
				do: [ :progress | 
					bar label: progress printString.
					progress isEmpty
						ifFalse: [ bar current: progress percentage ].
					progress resume ] ]