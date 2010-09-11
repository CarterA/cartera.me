require "yui/compressor"

module Jekyll
	
	class LessGenerator < Generator
		
		safe true
		
		def generate(site)
			stylesheets_directory = site.source + "/stylesheets"
			Dir[site.source + "/stylesheets/**/*.less"].each do |stylesheet|
				output_path = site.dest + "/stylesheets/" + File.basename(stylesheet, ".less") + ".css"
				%x[lessc -O2 #{stylesheet} #{output_path}]
				if site.config["mode"].eql?("deployment")
					output_file = File.new(output_path, "r")
					css_compressor = YUI::CssCompressor.new
					compressed_output = css_compressor.compress(output_file)
					new_output_file = File.new(output_path, "w")
					new_output_file.write(compressed_output)
				end
			end
		end
		
	end

end