actions
renameTo: aString 
	super renameTo: aString.
	zipFile renameTo: aString, '.zip'