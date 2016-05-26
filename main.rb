#!/bin/env ruby
# encoding: utf-8

begin

# Imports

require 'date'

require_relative "inc/page.home.rb"
require_relative "inc/page.profile.rb"
require_relative "inc/page.sailboat.rb"
require_relative "inc/page.projects.rb"
require_relative "inc/page.roadmap.rb"
require_relative "inc/page.cargo.rb"

require_relative "inc/object.layout.rb"
require_relative "inc/object.event.rb"
require_relative "inc/object.project.rb"
require_relative "inc/object.graph.rb"

$query = ARGV[0].to_s.gsub("+"," ").to_s

require("/xxiivv/Jiin/core/jiin.rb")
$jiin = Jiin.new

events = $jiin.command("disk load hundred")
# projects = $jiin.command("disk load projects")
projects = []
layout = Layout.new(events,projects)


puts "
<!DOCTYPE html>
<html>
<head>
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js' ></script>
	<link rel='stylesheet' type='text/css' href='inc/style.main.css' />
	<script src='inc/script.main.js'></script>
	<title>Hundred Rabbits | #{$query}</title>
</head>
<body>
	#{layout.body}
</body>
</html>
"

rescue Exception

	error = $@
	errorCleaned = error.to_s.gsub(", ","<br />").gsub("`","<b>").gsub("'","</b>").gsub("\"","").gsub("/var/www/wiki.xxiivv/public_html/","")
	errorCleaned = errorCleaned.gsub("[","\n").gsub("]","")
	puts "<pre><b>Error</b>     "+$!.to_s.gsub("`","<b>").gsub("'","</b>")+"<br/><b>Location</b>  "+errorCleaned+"<br /><b>Report</b>    Please, report this error to <a href='https://twitter.com/aliceffekt'>@aliceffekt</a><br /><br />CURRENTLY UPDATING XXIIVV, COME BACK SOON</pre>"

end