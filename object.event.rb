class Event

  def initialize(row)
    @date = row[0]
    @type = row[1]
    @title = row[2]
    @details = row[3]
    @url = row[4]
  end

  def date
    return @date
  end

  def type
    return @type
  end

  def title
    return @title
  end

  def details
    return @details
  end

  def url
    return @url
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

  def icon
    if type == "milestone" then return icon_milestone end
    if type == "event" then return icon_event end
    if type == "today" then return "" end
    return "<svg class='icon'><circle cx='10.5' cy='10.5' r='4' fill='#000'></circle></svg>"
  end

  def icon_milestone
    offset = 10.5
    return "<svg class='icon'><circle cx='#{offset}' cy='#{offset}' r='2'></circle><circle cx='#{offset}' cy='#{offset}' r='5'></circle></svg>"
  end

  def icon_event
    offset = 10.5
    return "<svg class='icon'><line x1='#{offset}' y1='#{offset + 5}' x2='#{offset + 5}' y2='#{offset}'/><line x1='#{offset}' y1='#{offset - 5}' x2='#{offset + 5}' y2='#{offset}'/><line x1='#{offset}' y1='#{offset + 5}' x2='#{offset - 5}' y2='#{offset}'/><line x1='#{offset}' y1='#{offset - 5}' x2='#{offset - 5}' y2='#{offset}'/></svg>"
  end

  def template
    return "
    <event time='#{time}' class='#{type}'>
      <span class='title'>#{title}</span>
      <span class='details'>#{details}</span>
      <span class='icon'>#{icon}</span>
      <line></line>
    </event>"
  end

end