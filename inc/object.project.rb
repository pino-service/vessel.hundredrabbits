class Project

  def initialize(row)
    @name = row[0]
    @date = row[1]
    @desc = row[2]
    @link = row[3]
  end

  def name
    return @name
  end

  def date
    return @date
  end

  def image
    return "<div style='width:100%; height:340px; border:1px solid #333; border-radius:4px'></div>"
  end

  def links
    return @link
  end

  def description
    return @desc
  end

  def template
    return "<c class='project'>#{image} #{description}</c>"
  end

end