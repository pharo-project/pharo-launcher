action
downloadToPositionableStream: anUrl
	^ self documents at: anUrl ifPresent: [:document | document readStream] ifAbsent: [ self defaultResponse readStream ]