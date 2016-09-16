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
  	<h1>#{@name}</h1>
  	<p>#{@bref}</p>
  	<p>#{@long}</p>
  	<p>#{@link}</p>
  	</c>"

  end

end