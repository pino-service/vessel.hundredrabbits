class Layout

    def page_patrons

        html = ""

        @projects.each do |project|
            if !project.isPaid then next end
            html += project.template
        end

        return "
        <c class='projects'>
        <w><p class='main'>Exclusive content for our <a href='https://www.patreon.com/100' target='_blank'>patrons</a>, updated monthly with new content.</p>
        <p>If you cannot access the files, contact us through Patreon and we will send you a new access code.</p></w>
        #{html}</c>"

    end

end