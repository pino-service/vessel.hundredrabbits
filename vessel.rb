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

  class Corpse

    include CorpseHttp

  end

  class Actions

    include ActionCollection

    def http q = nil

      layout = Layout.new(q,En.new("hundred").to_h)

      corpse = Corpse.new
      corpse.add_link("style.reset.css")
      corpse.add_link("style.main.css")
      corpse.add_script("jquery.core.js")
      corpse.add_script("jquery.main.js")
      corpse.set_title("Hundred Rabbits | #{$q}")
      corpse.set_body(layout.body)
      return corpse.result

    end

  end

  def actions ; return Actions.new(self,self) end

end