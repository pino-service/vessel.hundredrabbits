class Layout

    def page_projects

        html = ""

        En.new("hundred.projects").to_h.each do |p|
            project = Project.new(p)
            if project.is_paid then next end
            html += project.template
        end

        return "
        <c class='projects'>
        <w>
            <p class='main' style='margin-top:90px'>We also make things sometimes</p>
            <p>We work until we run out of power on the boat, here are a few things that we built inbetween the storms.</p>
            <p>If you are supporting us through Patreon, head over <a href='/Patreons'>here</a>.</p>
            #{html}
        </w></c>"

    end

end