class Layout

    def page_patreons

        html = ""

        Memory_Hash.new("projects",@path).to_h("project").each do |name,project|
            if !project.is_patreon then next end
            html += project.template
        end

        return "
        <c class='projects'>
        <w>
            <p class='main' style='margin-top:90px'>Exclusive content for our <a href='https://www.patreon.com/100' target='_blank'>patrons</a>, updated monthly with new content.</p>
            <p>If you cannot access the files, contact us through Patreon and we will send you a new access code.</p>
            #{html}
        </w></c>"

    end

end