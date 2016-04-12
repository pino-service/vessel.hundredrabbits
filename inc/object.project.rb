class Project

  def initialize row

    @name = row[0]
    @date = row[1]
    @desc = row[2]
    @link = row[3]
    @paid = row[4]

  end

  def name

    return @name

  end

  def date

    return @date

  end

  def isPaid

    return (@paid.to_i == 1) ? true : nil

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

  def description

    return @desc

  end

  def template

    return "
    <c class='project'>
      <w>
        <a class='photo' href='/#{name}'>#{image(1)}</a> 
        "+(!isPaid ? "<a class='photo' href='/#{name}'>#{image(2)}</a><a class='photo' href='/#{name}'>#{image(3)}</a>" : "")+"
        <hr/> 
      </w>
      #{description}
      #{links}
    </c>"

  end

end