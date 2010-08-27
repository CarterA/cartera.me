module TruncateToFirstParagraph
	def truncateToFirstParagraph(input)
		return input.split("</p>").first
	end
end

Liquid::Template.register_filter(TruncateToFirstParagraph)