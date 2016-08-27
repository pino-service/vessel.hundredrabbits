#!/bin/env ruby
# encoding: utf-8

$vessel_path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

# Imports

require 'date'

require_relative "inc/page.home.rb"
require_relative "inc/page.profile.rb"
require_relative "inc/page.sailboat.rb"
require_relative "inc/page.roadmap.rb"
require_relative "inc/page.cargo.rb"

require_relative "inc/object.layout.rb"
require_relative "inc/object.event.rb"
require_relative "inc/object.graph.rb"

class Hundred

	def http q = nil

		layout = Layout.new(query,En.new("hundred").to_h)

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
		</html>"

	end

end