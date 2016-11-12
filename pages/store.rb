class Layout

  def page_store

    html = ""

    Memory_Hash.new("projects",@path).to_h("project").each do |name,project|
        if !project.is_store then next end
        html += project.template
    end

    return "
    <c class='projects'>
    <w>
        <p class='main' style='margin-top:90px'>We also make things sometimes</p>
        <p>Here are a few projects made available for anyone to purchase.</p>
        #{html}
    </w></c>"

  end

end