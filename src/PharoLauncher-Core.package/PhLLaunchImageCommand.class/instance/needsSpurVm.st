action
needsSpurVm
	|version byteStream|

	byteStream := (context singleImage) file readStream.
	byteStream binary.
	version := byteStream nextLittleEndianNumber: 4.
	byteStream close.
	^version~=6505
