class Layout

    def initialize events, projects

        @events = events
        @projects = projects

    end

    # Tools

    def eventsOfType type

        array = []

        @events.reverse.each do |event|
            if event.type == type then array.push(event) end
        end

        return array

    end

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

    def projectWithName name

    	@projects.each do |project|
    		if project.name == name then return project end
    	end
        return false

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
            <li><a target='_blank' href='https://www.patreon.com/100'><img src='img/icon.patreon.png'/></a></li>
            <li><a target='_blank' href='https://twitter.com/hundredrabbits'><img src='img/icon.twitter.png'/></a></li>
            <li><a target='_blank' href='https://github.com/hundredrabbits'><img src='img/icon.github.png'/></a></li>
        </ul></c>"
    end

    def body

        html = ""

        if $query == "Roadmap" then html += page_roadmap
        elsif $query == "Projects" then html += page_projects
        elsif $query == "Sailboat" then html += page_sailboat
        elsif $query == "Profile" then html += page_profile
        elsif $query == "Patrons" then html += page_patrons
        elsif project = projectWithName($query) then html += page_project(project)
        else html += page_home end

        return "#{header}#{menu}#{html}#{footer}"
        
    end

    def menu
        return "<c class='menu'>
            <ul>
            <li><a href='/Profile' class='#{($query == 'Profile')?'selected':""}'>Nomads</a></li>
            <li><a href='/Sailboat' class='#{($query == 'Sailboat')?'selected':""}'>Sailboat</a></li>
            <li><a href='/Projects' class='#{($query == 'Projects')?'selected':""}'>Projects</a></li>
            <li><a href='/Roadmap' class='#{($query == 'Roadmap')?'selected':""}'>Roadmap</a></li>
            </ul>
        </c>"
    end
end