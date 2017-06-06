#!/bin/env ruby
# encoding: utf-8

class VesselHundredrabbits

  include Vessel

  def initialize id = 0

    super

    @name = "HundredRabbits"
    @path = File.expand_path(File.join(File.dirname(__FILE__), "/"))
    @docs = "The Hundred Rabbits website toolchain."
    @site = "http://100r.co"

    install(:custom,:serve)
    install(:custom,:get_location)
    install(:custom,:get_position)
    install(:generic,:help)
    install(:generic,:document)

  end

end