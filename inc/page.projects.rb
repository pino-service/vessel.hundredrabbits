class Layout

    def page_projects

        html = ""

        En.new("hundred.projects").to_h.each do |p|
            project = Project.new(p)
            html += project.template
        end

        return "
        <c class='patreon'>
        <w><p class='main'>Temporary project page.</p>
        <p>There might be errors? there will be errors. Will fix this shortly.</p>#{html}</w></c>"

    end

end