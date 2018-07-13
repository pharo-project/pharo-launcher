responses
oneBuildResponse
	^ '{"builds" : [
    {
      "number" : ',self lastSuccessfulBuildNumber printString,',
      "url" : "',self lastSuccessfulBuildUrlString,'"
    }]}'