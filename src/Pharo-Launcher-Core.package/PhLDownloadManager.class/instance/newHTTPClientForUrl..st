private
newHTTPClientForUrl: url
	^ ZnClient new
		url: url;
		enforceHttpSuccess: true;
		ifFail: [ :exception | self downloadFailureForUrl: url ];
		yourself