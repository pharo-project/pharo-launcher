running
setUpResponse: aResponse
	"Setup the mock Jenkins server to answer ==aResponse==."
	self downloadManager defaultResponse: aResponse