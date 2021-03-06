class Event

  attr_accessor :type
  attr_accessor :time

  def initialize(date,data)
    @date = date
    @time  = Timestamp.new(@date)
    @type = data["TYPE"]
    @title = data["NAME"]
    @value = data["VLUE"]
    @text = data["TEXT"]
    @url = data["LINK"]
    @geolocation = data["POSI"]
    @icon_align = 10.5
    @extraClasses = ""
  end

  def date
    return @date
  end

  def type
    return @type
  end

  def title
    return url ? "<a href='#{@url}' target='_blank'>#{@title}</a>" : "#{@title}"
  end

  def value
    return @value
  end

  def url
    if "#{@url}".strip == "" then return end
    return @url
  end

  def isPaid
    if @isPaid > 0 then return true end
    return
  end

  def text
    return @text
  end

  def geolocation
    return @geolocation.reverse
  end

  def latitude
    return @geolocation.first.split(",").first.strip.to_f
  end

  def longitude
    return @geolocation.first.split(",").last.strip.to_f
  end

  def year
    return @date.split("-")[0].to_i
  end

  def month
    return @date.split("-")[1].to_i
  end

  def day
    return @date.split("-")[2].to_i
  end

  def elapsed
    return @time.elapsed
  end

  def offset
    if year < 1 then return "" end

    timeDiff = (elapsed/86400)

    if timeDiff < -1 then return "In "+(timeDiff*-1).to_s+" days" end
    if timeDiff == -1 then return "tomorrow" end
    if timeDiff == 0 then return "today" end
    if timeDiff == 1 then return "yesterday" end
    if timeDiff == 7 then return "a week ago" end
    if timeDiff > 740 then return (timeDiff/30/12).to_s+" years ago" end
    if timeDiff > 60 then return (timeDiff/30).to_s+" months ago" end
    if timeDiff > 30 then return "a month ago" end

    return timeDiff.to_s+" days ago"
  end

  def offset_months
    return (elapsed/86400)/30
  end

  def imageExists date
    imageName = "#{date}".gsub("-","").to_i
    if imageName < 1 then return end
    if File.exist?("img/#{imageName}.jpg") then return true end
    return
  end

  def addClass className
    @extraClasses += "#{className} "
  end

  def template
    if type == "milestone" then return template_milestone end
    if type == "event" then return template_event end
    if type == "diary" then return template_diary end
    if type == "release" then return template_release end
    if type == "expense" then return template_expense end
    if type == "sail" then return template_sail end
    if type == "video" then return template_video end
    if type == "patreon" then return template_patreon end
    if type == "first" then return template_first end
    if type == "press" then return template_press end
    if type == "podcast" then return template_podcast end
    if type == "profile" then return template_profile end
    if type == "sailboat" then return template_sailboat end
    return template_missing
  end

  def template_missing
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='details'>#{value}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><circle cx='10.5' cy='10.5' r='3' fill='#fff'></circle></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_press
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <hr />
        "+(@text.to_s != "1" ? "<span class='note'>#{text}</span>" : "")+"
      </text>
      <svg class='icon'><circle cx='10.5' cy='10.5' r='3' stroke='#333' stroke-width='3'></circle></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_release
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <a href='#{url}' target='_blank'>#{Media.new("content","release."+@title.gsub(" ",".").downcase)}</a>
      <text>
        <span class='title'><a href='#{url}' target='_blank'>#{title}</a></span>
        <span class='details'>#{value}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_event
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='offset'>#{offset}</span>
        <hr />
        "+(@text.to_s != "1" ? "<span class='note'>#{text}</span>" : "")+"
      </text>
      <svg class='icon'><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_diary
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><circle cx='#{@icon_align}' cy='#{@icon_align}' r='3'></circle></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_expense
    return "
    <event time='#{time}' class='#{type} #{@extraClasses} #{(value.to_i > 0 ? "gain" : "spending")}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='details'>#{value}$</span>
        <hr />
        "+(@note.to_s != "1" ? "<span class='note'>#{text}</span>" : "")+"
      </text>
      <svg class='icon'><circle cx='#{@icon_align}' cy='#{@icon_align}' r='3'></circle></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_sail
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>Sail to #{title}</span>
        <span class='details'>+#{value}nm</span>
        <hr />
        "+(@note.to_s != "1" ? "<span class='note'>#{text}</span>" : "")+"
      </text>
      <svg class='icon'><polygon points='10.5,2 5.5,11 15.5,11' style='fill:#333' /></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_video
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <a href='#{url}' target='_blank'>#{Media.new("content","event."+@title.gsub(" ",".").downcase)}</a>
      <text>
        <span class='title'><a href='#{url}' target='_blank'>#{title}</a></span>
        <span class='details'>#{value}</span>
        <span class='offset'>#{offset}</span>
      </text>
      <svg class='icon'><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_patreon
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title} Patreons</span>
        <span class='details'>+#{value}$</span>
      </text>
      <hr />
    </event>"
  end

  def template_first
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='details'>#{value}</span>
      </text>
    </event>"
  end

  def template_podcast
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <text>
        <span class='title'>#{title}</span>
        <span class='offset'>Audio</span>
        <hr />"+(@note.to_s != "1" ? "<span class='note'>#{text}</span>" : "")+"
      </text>
      <svg class='icon'><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align + 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align + 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 4}' x2='#{@icon_align - 4}' y2='#{@icon_align}'/></svg>
      <line class='spacer'></line>
    </event>"
  end

  def template_profile
    return "
    <event time='#{time}' class='#{type}'>
      #{Media.new("content","profile.main")}
      <ul class='left'>
          <li><b>Devine Lu Linvega</b></li>
          <li>1986.03</li>
          <li>Developer</li>
          <li>English, French, Russian</li>
          <li><a href='https://twitter.com/neauoire' target='_blank'>@neauoire</a></li>
      </ul>
      <ul class='right'>
          <li><b>Rekka Bellum</b></li>
          <li>1984.12</li>
          <li>Illustrator</li>
          <li>English, French, Japanese</li>
          <li><a href='https://twitter.com/rekkabell' target='_blank'>@rekkabell</a></li>
      </ul>
    </event>"
  end

  def template_sailboat
    return "
    <event time='#{time}' class='#{type}'>
      #{Media.new("content","sailboat.main")}
      <ul class='left'>
          <li><b>Yamaha</b></li>
          <li>Length 33ft(10.16m)</li>
          <li>Built 1982</li>
          <li>Engine 13HP</li>
          <li><a href='https://github.com/hundredrabbits/Yamaha-33/blob/master/README.md' target='_blank'>Read more</a></li>
      </ul>
      <ul class='right'>
          <li><b>Tall Rig</b></li>
          <li>Hull Fiberglass</li>
          <li>Draft 6.25ft(1.91m)</li>
          <li>Keel Fin</li>
          <li>_</li>
      </ul>
    </event>"
  end

  def to_s

    return "#{date} -> #{type} : #{title}"

  end

end