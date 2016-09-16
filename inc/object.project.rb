class Project

  def initialize data
    
    @data = data
    @name = data.first
    @content = data.last
    @bref = @content['BREF']
    @long = @content['LONG']
    @link = @content['LINK']

  end

  def template

  	return "<c class='project'>
  	<img src='content/project.#{@name.downcase}.jpg'/>
  	<p class='main'>#{@name}</p>
  	<p>#{@bref}</p>
  	<p>#{@long}</p>
  	<p>#{@link}</p>
  	</c>"

  end

end