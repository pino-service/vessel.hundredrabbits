#!/bin/env ruby
# encoding: utf-8

$vessel_path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

# Imports

require_relative "inc/page.home.rb"
require_relative "inc/page.profile.rb"
require_relative "inc/page.sailboat.rb"
require_relative "inc/page.roadmap.rb"
require_relative "inc/page.patreon.rb"
require_relative "inc/page.projects.rb"

require_relative "inc/object.layout.rb"
require_relative "inc/object.event.rb"
require_relative "inc/object.graph.rb"
require_relative "inc/object.project.rb"

class Hundr

  class Actions

    include ActionCollection

    def http q = nil

      layout = Layout.new(q,En.new("hundred").to_h)

      return "
      <!DOCTYPE html>
      <html>
      <head>
        <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.8.1/jquery.min.js' ></script>
        <link rel='stylesheet' type='text/css' href='inc/style.main.css' />
        <script src='inc/script.main.js'></script>
        <title>Hundred Rabbits | #{$q}</title>
      </head>
      <body>
        #{layout.body}
      </body>
      </html>"

    end

  end

  def actions ; return Actions.new(self,self) end

end