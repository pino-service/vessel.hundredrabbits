#!/bin/env ruby
# encoding: utf-8

class ActionGet_location

  include Action
  
  def initialize q = nil

    super

    @name = "Get_Location"
    @docs = "Return latest location."

  end

  def act q = "Home"

    load_folder("#{@host.path}/objects/*")

    timeline = Memory_Hash.new("timeline",@host.path).to_h("event")

    timeline.each do |date,event|
      if !event.type then next end
      if !event.type.like("sail") then next end
      return event.title
    end

    return "Unknown Location"

  end

end