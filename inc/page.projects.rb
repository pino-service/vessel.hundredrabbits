class Layout

    def page_projects

    	html = ""

    	@projects.each do |project|
            if project.isPaid then next end
            html += project.template
        end

        return "
        <c class='projects'>
        <w><p class='main'>Here are a few things we made along the way.</p></w>
        #{html}</c>"

    end

    def page_project project

    	html = ""
    	html += project.template

    	return html

    end

end