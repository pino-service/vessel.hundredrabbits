#!/bin/env ruby
# encoding: utf-8

$nataniev.require("corpse","http")

class ActionServe

  include Action
  
  def initialize q = nil

    super

    @name = "Serve"
    @docs = "Deliver the Hundred Rabbits website."

  end

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
