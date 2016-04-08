class Project

  def initialize row

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

  def image id

    return "<img src='files/projects.#{name.downcase}.#{id}.jpg'/>"

  end

  def links

    html = "<ul class='links'>"
    @link.lines.each do |link|
      html += "<li><a class='#{link.split("|")[2]}' href='#{link.split("|")[1]}'>"+link.split("|").first+"</a></li>"
    end
    html += "</ul>"
    return "<w>"+html+"</w>"

  end