accessing
cacheFile	
	^ (self baseDirectory / 'cache', 'json') ensureCreateFile