private
imageFormatNumberFromStream: aStream
	| number |
	number := aStream nextLittleEndianNumber: 4.
	aStream close.
	^ number