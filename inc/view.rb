#!/bin/env ruby
# encoding: utf-8

begin

# Imports

require "mysql"
require 'date'

require_relative "page.home.rb"
require_relative "page.profile.rb"
require_relative "page.sailboat.rb"
require_relative "page.projects.rb"
require_relative "page.roadmap.rb"
require_relative "page.patrons.rb"

require_relative "object.layout.rb"
require_relative "object.event.rb"
require_relative "object.project.rb"
require_relative "object.graph.rb"

require_relative "../../tools/database.rb"

$query = ARGV[0].to_s.gsub("+"," ").to_s

$oscean = Oscean.new()
$oscean.connect
events = $oscean.fetchEvents.sort_by { |k| k.time }
projects = $oscean.fetchProjects.sort_by { |k| k.date }
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