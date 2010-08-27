module Jekyll
	class CommitHashTag < Liquid::Tag
		def render(context)
			"#{%x[git log --pretty=format:%H -1]}"
		end
	end
end

Liquid::Template.register_tag("commit_hash", Jekyll::CommitHashTag)