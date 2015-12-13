#!/bin/env ruby
# encoding: utf-8

begin

# Imports

require "mysql"
require 'date'

require_relative "object.event.rb"
require_relative "object.graph.rb"
require_relative "../../tools/database.rb"

$oscean = Oscean.new()
$oscean.connect

progress = $oscean.fetchProgress

events = $oscean.fetchEvents.sort_by { |k| k.time }

# Events

count = 0
events_html = ""
events.each do |event|
	event.addClass((count % 2 == 0 ? "even" : "odd"))
	events_html += event.template
	count += 1
end

# Extras

events_html += "
<marker id='marker_top'>
	<svg class='icon'>
		<line x1='0' y1='15' x2='10.5' y2='10'/>
		<line x1='20' y1='15' x2='10.5' y2='10'/>
	</svg>
</marker>
<marker id='marker_bottom'>
	<svg class='icon'>
		<line x1='0' y1='5' x2='10.5' y2='10'/>
		<line x1='20' y1='5' x2='10.5' y2='10'/>
	</svg>
</marker>"

# Months

monthMarker = events.first.time
while monthMarker < events.last.time
	monthMarker += 2592000
	events_html += "<event time='#{monthMarker}' class='month'><span>#{Time.at(monthMarker).strftime("%B")[0,3]}</span></event>"
end

# Today

events_html += Event.new(["#{Time.now.year}-#{Time.now.month}-#{Time.now.day}","today","Today",""]).template

# Logo

logo = ""
x = 0
while x < 10
	y = 0
	while y < 10
		logo += "<circle cx='#{x * 5 + 5}' cy='#{y * 5 + 5}' r='2' fill='white'></circle>"
		y += 1
	end
	x += 1
end
logo = "<svg class='logo'>#{logo}</svg>"

puts "
<!DOCTYPE html>
<html>
<head>
	<script src='https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js' ></script>
	<link rel='stylesheet' type='text/css' href='inc/style.main.css' />
	<script src='inc/script.main.js'></script>
</head>
<body>
	<timeline from='#{events.first.time}' to='#{events.last.time}'>
		#{events_html}
	</timeline>
	<content>
		<img src='img/about.jpg'/>
		<div>
			<h1>Hundredrabbits</h1>
			<h2>We are a team of game designers documenting our lives living aboard a sailboat on the Pacific Ocean. </h2>
			#{Graph.new(progress).draw}
			<p>We have currently #{progress.first['patrons']} patrons with a monthly pledge of #{progress.first['pledged']}$. Support us on <a href='https://patreon.com/100' target='_blank'>Patreon</a>, through which we release weekly updates and give away stickers and download codes.</p>
			
			<a href='https://www.patreon.com/100' class='icon patreon' target='_blank'></a>
			<a href='https://github.com/hundredrabbits' class='icon github' target='_blank'></a>
			<a href='https://twitter.com/hundredrabbits' class='icon twitter' target='_blank'></a>
		</div>
	</content>
	<footer>
		#{logo}
		<p><span>hundredrabbits</span></p>
	</footer>
</body>
</html>
"

rescue Exception

	error = $@
	errorCleaned = error.to_s.gsub(", ","<br />").gsub("`","<b>").gsub("'","</b>").gsub("\"","").gsub("/var/www/wiki.xxiivv/public_html/","")
	errorCleaned = errorCleaned.gsub("[","\n").gsub("]","")
	puts "<pre><b>Error</b>     "+$!.to_s.gsub("`","<b>").gsub("'","</b>")+"