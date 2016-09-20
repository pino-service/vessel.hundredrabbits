#!/bin/env ruby
# encoding: utf-8

$vessel_path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

# Imports

require_relative "inc/page.home.rb"
require_relative "inc/page.profile.rb"
require_relative "inc/page.sailboat.rb"
require_relative "inc/page.roadmap.rb"
require_relative "inc/page.patreons.rb"
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

    def http q = "Home"

      layout = Layout.new(q,En.new("hundred").to_h)

      # Corpse
      
      corpse = Corpse.new
      
      corpse.add_meta("description","A design studio on a sailboat")
      corpse.add_meta("keywords","sailing, patreon, indie games, design, liveaboard")
      corpse.add_meta("viewport","width=device-width, initial-scale=1, maximum-scale=1")
      corpse.add_meta("apple-mobile-web-app-capable","yes")

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