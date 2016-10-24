#!/bin/env ruby
# encoding: utf-8

$nataniev.require("corpses","http")

# Imports

require_relative "pages/home.rb"
require_relative "pages/profile.rb"
require_relative "pages/sailboat.rb"
require_relative "pages/roadmap.rb"
require_relative "pages/patreons.rb"
require_relative "pages/projects.rb" 

require_relative "objects/layout.rb"
require_relative "objects/event.rb"
require_relative "objects/graph.rb"
require_relative "objects/project.rb"

class Hundr

  include Vessel

  class Corpse

    include CorpseHttp

  end

  class Actions

    include ActionCollection

    def serve q = "Home"

      path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

      layout = Layout.new(q,Memory_Hash.new("timeline",path))
      layout.path = path

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
      
      corpse.title = "Hundred Rabbits | #{q}"
      corpse.body  = layout.body
      
      return corpse.result

    end

  end

  def actions ; return Actions.new(self,self) end

end