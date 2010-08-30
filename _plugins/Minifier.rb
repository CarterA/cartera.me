require "yui/compressor"

module Jekyll
	class CSSMinifier < Converter
		safe true
		priority :normal
		def matches(extension)
			extension =~ /css/i
		end
		def output_ext(extension)
			".css"
		end
		def convert(content)
			return content unless (@config["mode"].eql?("deployment"))
			css_compressor = YUI::CssCompressor.new
			return css_compressor.compress(content)
		end
	end
end