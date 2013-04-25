runnnig
loadAndRun
	self download: (self listElement at: self listModel selectedItem).
	self unzip: (self listModel selectedItem).