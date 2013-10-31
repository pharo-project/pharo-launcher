accessing
simplifiedTemplatesAndGroups
	^ simplifiedTemplatesAndGroups
		ifNil: [ 
			"#simplifiedTemplatesAndGroups will typically use the network and may fail. If the network is unreliable, it is better to save the error and not call #templateAndGroups a thousand times. Let the user interface decide when to try again (by calling #reset)."
			simplifiedTemplatesAndGroups := [ delegate simplifiedTemplatesAndGroups ]
				on: PhLError
				do: [ :err | Array with: err ] ]