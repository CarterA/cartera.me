module VCFPlugin
	module LatestFileRevisionFilter
		def include_stylesheet(file_path)
			unprocessed_stylesheet_path = "stylesheets/#{file_path}"
			processed_stylesheet_path = "/stylesheets/#{file_path}?revision=#{VCFPlugin::latest_file_revision(unprocessed_stylesheet_path)}"
			processed_stylesheet_path
		end
	end
	def self.latest_file_revision(file_path)
		%x[git log --pretty=format:%H -1 #{file_path}]
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
		end
		def render(context)
			unproccessed_stylesheet_path = "stylesheets/#{@stylesheet_name}"
			processed_stylesheet_path = "/stylesheets/#{@stylesheet_name}?revision=#{VCFPlugin::latest_file_revision(unproccessed_stylesheet_path)}"
			"<link rel=\"stylesheet\" href=\"#{processed_stylesheet_path}\">"
		end
	end
	class StylesheetsTag < Liquid::Tag
		def render(context)
			puts context.environments.to_s
			if (!(context["page"].respond_to?("stylesheets")))
				return
			end
			stylesheet_names = context["page"].stylesheets
			for stylesheet_name in stylesheet_names
				unprocessed_stylesheet_path = "stylesheets/#{stylesheet_name}"
				processed_stylesheet_path = "/stylesheets/#{stylesheet_name}?revision=#{VCFPlugin::latest_file_revision(unprocessed_stylesheet_path)}"
				"<link rel=\"stylesheet\" href=\"#{processed_stylesheet_path}\">"
			end
		end
	end
end

Liquid::Template.register_filter(VCFPlugin::LatestFileRevisionFilter)
Liquid::Template.register_tag("include_script", VCFPlugin::ScriptTag)
Liquid::Template.register_tag("include_stylesheet", VCFPlugin::StylesheetTag)
Liquid::Template.register_tag("include_stylesheets", VCFPlugin::StylesheetsTag)