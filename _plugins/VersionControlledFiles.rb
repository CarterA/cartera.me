module VCFPlugin
	module LatestFileRevisionFilter
		def include_stylesheet(file_path)
			unprocessed_stylesheet_path = "stylesheets/#{file_path}"
			processed_stylesheet_path = "/stylesheets/#{file_path}?revision=#{VCFPlugin::latest_file_revision(unprocessed_stylesheet_path)}"
			processed_stylesheet_path
		end
	end
	def self.latest_file_revision(file_path)
		result = %x[git log --pretty=format:%H -1 -- #{file_path}]
		return result unless result == ""
		return %x[git rev-parse HEAD]
	end
	class ScriptTag < Liquid::Tag
		def initialize(tag_name, script_name, tokens)
			super
			@script_name = script_name.strip
		end
		def render(context)
			unproccessed_script_path = "scripts/#{@script_name}"
			processed_script_path = "/scripts/#{@script_name}?revision=#{VCFPlugin::latest_file_revision(unproccessed_script_path)}"
			"<script src=\"#{processed_script_path}\"></script>"
		end
	end
	class StylesheetTag < Liquid::Tag
		def initialize(tag_name, stylesheet_name, tokens)
			super
			@stylesheet_name = stylesheet_name.strip
			@original_extension = File.extname(@stylesheet_name)
			@stylesheet_name = @stylesheet_name.sub(/#{Regexp.escape(File.extname(@stylesheet_name))}$/, "")
		end
		def render(context)
			unproccessed_stylesheet_path = "stylesheets/#{@stylesheet_name}#{@original_extension}"
			processed_stylesheet_path = "/stylesheets/#{@stylesheet_name}.css?revision=#{VCFPlugin::latest_file_revision(unproccessed_stylesheet_path)}"
			"<link rel=\"stylesheet\" href=\"#{processed_stylesheet_path}\">"
		end
	end
end

Liquid::Template.register_filter(VCFPlugin::LatestFileRevisionFilter)
Liquid::Template.register_tag("include_script", VCFPlugin::ScriptTag)
Liquid::Template.register_tag("include_stylesheet", VCFPlugin::StylesheetTag)