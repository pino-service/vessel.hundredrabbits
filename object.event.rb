class Event

  def initialize(row)
    @date = row[0]
    @type = row[1]
    @title = row[2]
    @details = row[3]
    @url = row[4]
    @isPaid = row[5].to_i
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

    return url ? "<a href='#{@url}' target='_blank' class='#{((isPaid) ? "paid" : "")}'>#{@title}</a>" : "#{@title}"
  end

  def details
    return @details
  end

  def url
    if "#{@url}".strip == "" then return end
    return @url
  end

  def isPaid
    if @isPaid > 0 then return true end
    return
  end

  def year
    return @date[0,4].to_i
  end

  def month
    return @date[5,2].to_i
  end

  def day
    return @date[8,2].to_i
  end

  def time
    return Date.new(year,month,day).to_time.to_i
  end

  def elapsed
    return Time.new.to_i - time
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
    return template_missing
  end

  def template_missing
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <p>
        <span class='title'>#{title}</span>
        <span class='details'>#{details}</span>
        <span class='offset'>#{offset}</span>
      </p>
      <svg class='icon'></svg>
      <line></line>
    </event>"
  end

  def template_release
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <p>
        <span class='title'>Release: #{title}</span>
        <span class='details'>#{details}</span>
        <span class='offset'>#{offset}</span>
      </p>
      <svg class='icon'><circle cx='10.5' cy='10.5' r='5' fill='#000'></circle></svg>
      <line></line>
    </event>"
  end

  def template_event
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <p>
        <span class='title'>#{title}</span>
        <span class='offset'>#{offset}</span>
      </p>
      <svg class='icon'><line x1='#{@icon_align}' y1='#{@icon_align + 5}' x2='#{@icon_align + 5}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 5}' x2='#{@icon_align + 5}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align + 5}' x2='#{@icon_align - 5}' y2='#{@icon_align}'/><line x1='#{@icon_align}' y1='#{@icon_align - 5}' x2='#{@icon_align - 5}' y2='#{@icon_align}'/></svg>
      <line></line>
    </event>"
  end

  def template_milestone
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <p>
        <span class='title'>Milestone: #{title}</span>
        <span class='details'>#{details}</span>
        <span class='offset'>#{offset}</span>
      </p>
      <svg class='icon'><circle cx='#{@icon_align}' cy='#{@icon_align}' r='2' style='stroke:red'></circle><circle cx='#{@icon_align}' cy='#{@icon_align}' r='5'></circle></svg>
      <line></line>
    </event>"
  end

  def template_diary
    return "
    <event time='#{time}' class='#{type} #{@extraClasses}'>
      <p>
        <span class='title'>#{title}</span>
        <span class='offset'>#{offset}</span>
      </p>
      <svg class='icon'><circle cx='#{@icon_align}' cy='#{@icon_align}' r='3'></circle></svg>
      <line></line>
    </event>"
  end

end