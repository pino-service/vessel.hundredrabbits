class Project

  def initialize data
    
    @data = data
    @name = data.first
    @content = data.last
    @bref = @content['BREF']
    @long = @content['LONG'].to_a
    @link = @content['LINK'].to_a

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