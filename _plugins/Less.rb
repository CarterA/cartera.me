require "yui/compressor"

module Jekyll
	
	class LessConverter < Converter
	
		safe true

		def matches(ext)
			ext =~ /less/i
		end

		def output_ext(ext)
			".css"
		end

		def convert(content)
			temporary_file = Tempfile.new("lessjstemp")
			temporary_file << content
			temporary_file.flush
			if @config["mode"].eql?("development")
				result = %x[lessc -O2 #{temporary_file.path}]
				css_compressor = YUI::CssCompressor.new
				result = css_compressor.compress(result)
			else
				result = %x[lessc #{temporary_file.path}]
			end
			temporary_file.close
			result
		end

	end

end