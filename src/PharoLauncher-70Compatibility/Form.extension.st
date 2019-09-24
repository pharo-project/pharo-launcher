Extension { #name : #Form }

{ #category : #'*PharoLauncher-70Compatibility' }
Form class >> fromBase64String: aBase64EncodedString [
	
	^ self fromBinaryStream: aBase64EncodedString base64Decoded asByteArray readStream
]
