as yet unclassified
loadAndRun
	self download: (self dictionary at: self listModel selectedItem).
	self unzip: (self dictionary at: self listModel selectedItem).