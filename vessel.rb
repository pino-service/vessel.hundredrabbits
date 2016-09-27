#!/bin/env ruby
# encoding: utf-8

$vessel_path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

# Imports

require_relative "page/home.rb"
require_relative "page/profile.rb"
require_relative "page/sailboat.rb"
require_relative "page/roadmap.rb"
require_relative "page/patreons.rb"
require_relative "page/projects.rb" 

require_relative "object/layout.rb"
require_relative "object/event.rb"
require_relative "object/graph.rb"
require_relative "object/project.rb"

class Hundr

  class Corpse

    include CorpseHttp

  end

  class PassiveActions

    include ActionCollection

    def answer q = "Home"

      path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

      layout = Layout.new(q,En.new("hundred",path).to_h)

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
      corpse.set_view(layout.body)
      
      return corpse.result

    end

  end

  def passive_actions ; return PassiveActions.new(self,self) end

end