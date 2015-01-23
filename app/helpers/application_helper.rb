module ApplicationHelper

	def add_meta_tag options
		html = ""
		options.each do |o|
			html+= "<meta content='#{o.last}' name='#{o.first.to_s}' />"
		end
		html.html_safe
	end

	def add_meta_tags
		html = ""
		if @profile
			html+= add_meta_tag description: @profile.name, keywords: @profile.name
		elsif @recipe
			html+= add_meta_tag description: @recipe.description, keywords: @recipe.title
		else
			html+= add_meta_tag description: 'Post your recipes and share with your friends'
		end
		html.html_safe
	end

end
