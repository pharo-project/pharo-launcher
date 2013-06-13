action
downloadToPositionableStream: url mimeType: mimeType
	"Unfortunately, Zinc (and HTTP in general) doesn't support positionable streams so well. So we have to get the whole content as a collection and stream over it."
	^ ((self newHTTPClientForUrl: url)
			beOneShot;
			accept: mimeType;
			enforceAcceptContentType: true;
			get) readStream