class Layout

    def page_projects

    	html = ""

        html += "<p>We are building a new project page, in the meantime, follow our projects on <a href='https://twitter.com/hundredrabbits' target='_blank'>Twitter</a>.</p>"

        return "
        <c class='projects'>#{html}</c>"

    end

    def page_project project

    	html = ""
    	html += project.template

    	return html

    end

end