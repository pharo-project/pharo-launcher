helpers
write: aDocumentItem
	| writer |
	^ String
		streamContents: [ :stream | 
			writer := self createWriterOn: stream.
			writer configuration: self configuration.
			writer start: aDocumentItem ]