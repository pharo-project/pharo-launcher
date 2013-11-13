as yet unclassified
execute
	| sourceURLstring baseCutIndex baseURLString |
	sourceURLstring := context singleTemplate url asString.
	baseCutIndex := sourceURLstring findString: '/lastSuccessfulBuild' .
	baseURLString := sourceURLstring first: baseCutIndex - 1.

	"Here each platform should invoke its web browser, but for now... "
	Clipboard clipboardText: baseURLString.
	self inform: baseURLString , String crlf , 'copied to clipboard'.
