asserting
assert: result includesSubstring: expected
	self
		assert: (result includesSubstring: expected)
		description:
			('''{1}'' not in ''{2}'''
				format:
					{expected.
					result})