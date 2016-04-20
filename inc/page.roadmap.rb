class Layout

    def page_roadmap
        return "
        <c class='roadmap'><w><p class='main'>We aim to document the costs, the events and sails worth remembering.</p></w>
        #{status}
        #{timeline}
        #{seal}"
    end

    def timeline

        html = ""

        count = 0
        @events.reverse.each do |event|
            if event.type == "press" then next end
            if event.type == "hidden" then next end
            event.addClass( (count % 2 == 0) ? "odd" : "even" )
            html += event.template
            count += 1
        end

        html += "<center></center>"

        return " <c class='timeline'>#{html}</c>"

    end

    def status

        html = ""

        distance = 0
        expenses = 0

        @events.reverse.each do |event|
            if event.type == "sail" then distance += event.details.to_f end
            if event.type == "expense" then expenses += event.details.to_f end    
        end

        html += "<h2>Sailed #{distance.to_i}nm<small>#{(distance.to_f/@events.first.offset_months.to_f).to_i}nm per month</small></h2> <h2>Spent #{format_money(expenses.to_i * -1)}<small>#{format_money((expenses.to_i * -1)/@events.first.offset_months)} per month</small></h2><hr/>"

        return " <c class='status'><w>#{html}</w></c>"

    end

    def seal
        return "<c class='seal'><img src='img/seal.png' style='max-width:150px; margin:100px auto'/></c>"
    end


end