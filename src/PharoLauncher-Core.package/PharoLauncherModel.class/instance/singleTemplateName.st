selection
singleTemplateName
	"returns the project name and cuts out text between parentheses"
	self
		ensure: self hasSingleTemplateSelected.
	^ (selection pathes first second splitOn: '-(') first 