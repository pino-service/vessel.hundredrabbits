class Layout

    def page_projects

    	html = ""

    	@projects.each do |project|
            if project.isPaid then next end
            html += project.template
        end

        return "
        <c class='projects'>#{html}</c>"

    end

    def page_project project

    	html = ""
    	html += project.template

    	return html

    end

end