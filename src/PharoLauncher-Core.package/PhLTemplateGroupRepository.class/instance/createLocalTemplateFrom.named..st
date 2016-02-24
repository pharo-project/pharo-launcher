action
createLocalTemplateFrom: anImage named: aString
	| localTemplateGroup |
	localTemplateGroup := self roots detect: [ :each | each name = 'Local' ].
	(localTemplateGroup templatesAndGroups anySatisfy: [ :each | each name = aString ])
		ifTrue: [ PhLError signal: 'A local template with the same name already exists' ].
	ZipArchive new
		addFile: anImage file as: aString , '.image';
		addFile: anImage file parent / anImage file basenameWithoutExtension , 'changes' as: aString , '.changes';
		writeToFileNamed: PhLLocalTemplate default baseDirectory / aString asFileReference , 'zip'.
	self flag: #continueFromHere