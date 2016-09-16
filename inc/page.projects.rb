class Layout

    def page_projects

        html = ""

        En.new("hundred.projects").to_h.each do |p|
            project = Project.new(p)
            html += project.template
        end

        return "
        <c class='patreon'>
        <w><p class='main'>Exclusive content for our <a href='https://www.patreon.com/100' target='_blank'>patrons</a>, updated monthly with new content.</p>
        <p>If you cannot access the files, contact us through Patreon and we will send you a new access code.</p>#{html}</w></c>"

    end

end