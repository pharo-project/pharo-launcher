runnnig
loadAndRun: anElement
	self download: anElement .
	self unzip: anElement  .
	self run: (self userChoiceName: anElement)