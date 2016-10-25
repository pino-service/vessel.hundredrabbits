#!/bin/env ruby
# encoding: utf-8

$nataniev.require("corpse","http")

class VesselHundredrabbits

  include Vessel

  def initialize id = 0

    super

    @name = "Hundred Rabbits"
    @path = File.expand_path(File.join(File.dirname(__FILE__), "/"))

    install(:default,:serve)

  end

end

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

class ActionServe

  include Action

  def act q = "Home"

    layout = Layout.new(q,Memory_Hash.new("timeline",@host.path))
    layout.path = @host.path

    # Corpse
    
    corpse = CorpseHttp.new(@host,q)
    
    corpse.title = "Hundred Rabbits | #{q}"
    corpse.body  = layout.body
    
    return corpse.result

  end

end

class CorpseHttp

  def build

    add_meta("description","A design studio on a sailboat")
    add_meta("keywords","sailing, patreon, indie games, design, liveaboard")
    add_meta("viewport","width=device-width, initial-scale=1, maximum-scale=1")
    add_meta("apple-mobile-web-app-capable","yes")

    add_link("style.reset.css")
    add_link("style.main.css")
    
    add_script("jquery.core.js")
    add_script("jquery.main.js")

  end

end