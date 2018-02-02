items creation
fetchOnlineImage
	Transcript cr;show: 'ok'.
	self dictionary: Dictionary new.
	self urlList do: [ :anURL |self dictionary addAll: (self fetchOnlineImage: anURL) ].