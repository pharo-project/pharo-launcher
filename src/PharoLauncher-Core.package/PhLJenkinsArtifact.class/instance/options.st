accessing
options
	"Return a dictionary of the options used to build this artifact (typically the version of the image, the version of the project...)."

	"Because Jenkins doesn't store this information properly, we have to parse it from the url"
	^ parent url jenkinsOptions