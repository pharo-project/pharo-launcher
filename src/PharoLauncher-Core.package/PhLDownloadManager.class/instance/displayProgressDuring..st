private
displayProgressDuring: workBlock
	"Inform user about download progression"

	UIManager default
		informUserDuring: [ :bar | 
			workBlock
				on: HTTPProgress
				do: [ :progress | 
					bar label: progress printString.
					progress isEmpty
						ifFalse: [ bar current: progress percentage ].
					progress resume ] ]