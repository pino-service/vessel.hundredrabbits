class Layout

    def initialize events, projects

        @events = events
        @projects = projects

    end

    # Tools

    def lastEventOfType type

        @events.reverse.each do |event|
            if event.type == type then return event end
        end

        return "[Missing]"

    end

    def format_money int

        int = "#{int}"

        return "#{int[0,int.length-3]}'#{int[-3,3]}$"

    end

    def header

        logo = ""
        size = 8
        radius = 3
        x = 0
        while x < 10
            y = 0
            while y < 10
                logo += "<circle cx='#{x * size + size}' cy='#{y * size + size}' r='#{radius}' fill='white'></circle>"
                y += 1
            end
            x += 1
        end
        return "<c class='header'><a href='/'><svg class='logo'>#{logo}</svg></a></c>"

    end

    def introduction
        return "
        <c class='introduction'>
            <w>
                <h>
                    <img src='http://100r.co/img/nomads.plan.png'/>
                    <h1>The Nomads</h1>
                    <ul>
                        <li><b>Illustrator</b><span><a href='https://twitter.com/rekkabell' target='_blank'>Rekka Bellum</a></span></li>
                        <li><b>Developer</b><span>Devine Lu Linvega</span></li>
                    </ul>
                </h>
                <h>
                    <img src='http://100r.co/img/yamaha.plan.png'/>
                    <h1>The Office</h1>
                    <ul>
                        <li><b>Model</b><span>Yamaha 33' 1982</span></li>
                        <li><b>Details</b><span><a target='_blank' href='https://github.com/hundredrabbits/Yamaha-33/blob/master/README.md'>Full Spec</a></span></li>
                    </ul>
                </h>
            </w>
        </c>"
    end

    def timeline

        html = ""

        count = 0
        @events.reverse.each do |event|
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

    def projects

        html = ""

        @projects.each do |project|
            html += project.template
        end

        return html

    end

    def page_home
        return "
        #{introduction}
        "
    end

    def page_profile
        return "
        <c class='profile'>
        <img class='main' src='img/main.profile.jpg'/>
        <w>
            <p class='main'>Two unlikely sailors.</p>
            <h>
            <ul>
                <li><b>Devine Lu Linvega</b></li>
                <li>1986.03</li>
                <li>Developer</li>
                <li>English, French, Russian</li>
                <li><a href='https://twitter.com/neauoire' target='_blank'>@neauoire</a></li>
            </ul>
            </h>
            <h>
            <ul>
                <li><b>Rekka Bellum</b></li>
                <li>1984.12</li>
                <li>Illustrator</li>
                <li>English, French, Japanese</li>
                <li><a href='https://twitter.com/rekkabell' target='_blank'>@rekkabell</a></li>
            </ul>
            </h>
        </w>
        <p>Feel free to contact us with any question you may have, will will be happy to answer you.</p>
        </c>"
    end

    def page_roadmap
        return "
        <c class='roadmap'><w><p class='main'>We aim to document the costs, the events and sails worth remembering.</p></w>
        #{status}
        #{timeline}
        #{seal}"
    end

    def page_sailboat # #{lastEventOfType("sail").title}
        return "
        <c class='sailboat'>
        <img class='main' src='img/sailboat.main.jpg'/>
        <w>
            <p class='main'>Our vessel is a 33' Yamaha Sloop, built in 1982. It is ocean ready and sleeps 5 passengers comfortably.</p>
           