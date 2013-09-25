private
newHTTPClientForUrl: url
	^ ZnClient new
		signalProgress: true;
		url: url;
		enforceHttpSuccess: true;
		
		ifFail: [ :exception | self downloadFailureForUrl: url ];
		yourself