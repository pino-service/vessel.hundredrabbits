class Project

  def initialize name,data
    
    @name = name
    @content = data
    @bref = @content['BREF']
    @long = @content['LONG'].to_a
    @link = @content['LINK'].to_a
    @paid = @content['PAID'].to_s

  end

  def is_store

    @link.each do |k,v|
      if k.like("store") then return true end
    end
    return nil

  end

  def is_patreon

    @link.each do |k,v|
      if k.like("patreons") then return true end
    end
    return nil

  end

  def template

    html_links = ""
    @link.each do |k,v|
      html_links += "<a href='#{v}' target='_blank' class='external'>#{k}</a>"
    end

  	return "<c class='project'>
  	<img src='content/project.#{@name.downcase}.jpg'/>
  	<p class='main'>#{@name}</p>
  	<h3>#{@bref}</h3>
  	#{@long.runes}
  	#{html_links}
  	</c>"

  end

end