class Layout

    attr_accessor :path

    def initialize query, events

        @query = query.downcase
        @events = events.to_h("event")
        @path = nil

    end

    # Tools

    def eventsOfType type

        array = []

        @events.sort_by{|k,to_i,v| k}.reverse.each do |date,event|
            if event.type == type then array.push(event) end
        end

        return array

    end

    def lastEventOfType type

        @events.reverse.each do |date,event|
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

    def footer
        return "<c class='footer'>
        <ul>
            <li><a target='_blank' href='https://www.patreon.com/100'><img src='img/interface/icon.patreon.png'/></a></li>
            <li><a target='_blank' href='https://twitter.com/hundredrabbits'><img src='img/interface/icon.twitter.png'/></a></li>
            <li><a target='_blank' href='https://github.com/hundredrabbits'><img src='img/interface/icon.github.png'/></a></li>
        </ul></c>"
    end

    def body

        html = ""

        if @query == "roadmap" then html += page_roadmap
        elsif @query == "sailboat" then html += page_sailboat
        elsif @query == "profile" then html += page_profile
        elsif @query == "patreons" then html += page_patreons
        elsif @query == "projects" then html += page_projects
        elsif @query == "store" then html += page_store
        else html += page_home end

        return "#{header}#{menu}#{html}#{footer}"
        
    end

    def menu
        return "<c class='menu'>
            <ul>
            <li><a href='/Profile' class='#{(@query == 'profile') ? 'selected' : ""}'>Nomads</a></li>
            <li><a href='/Sailboat' class='#{(@query == 'sailboat') ? 'selected' : ""}'>Sailboat</a></li>
            <li><a href='/Roadmap' class='#{(@query == 'roadmap') ? 'selected' : ""}'>Roadmap</a></li>
            
            <li><a href='/Projects' class='#{(@query == 'projects') ? 'selected' : ""}'>Projects</a></li>
            <li><a href='/Store' class='#{(@query == 'store') ? 'selected' : ""}'>Store</a></li>
            #{(@query == 'patreons') ? '<li><a href=\'/Roadmap\' class=\'selected\' style=\'color:red\'>Patreons</a></li>' : ""}
            </ul>
        </c>"
    end
end