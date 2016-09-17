class Layout

    def page_projects

        html = ""

        En.new("hundred.projects").to_h.each do |p|
            project = Project.new(p)
            html += project.template
        end

        return "
        <c class='projects'>
        <w>
            <p class='main' style='margin-top:90px'>We also make things sometimes</p>
            <p>We work until we run out of power on the boat, here are a few things that we built inbetween the storms.</p>
            #{html}
        </w></c>"

    end

end