accessing
url
	"Jenkins JSON API does not assign urls to artifacts. You have to get the url of build or run that defines the artifact (i.e., the artifact's parent)."
	^ parent url / 'artifact' / self relativePath