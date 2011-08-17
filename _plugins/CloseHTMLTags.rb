require "bundler/setup"
require 'hpricot'

module CloseHTMLTags
	def closeHTMLTags(input)
		text = Hpricot(input)
		return text.to_s
	end
end

Liquid::Template.register_filter(CloseHTMLTags)