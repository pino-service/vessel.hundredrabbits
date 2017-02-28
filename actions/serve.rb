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

    load_folder("#{@host.path}/objects/*")

    # Corpse
    
    corpse = CorpseHttp.new(@host,q)
    
    corpse.title = "Hundred Rabbits | #{q}"
    
    timeline = Memory_Hash.new("timeline",@host.path)
    corpse.events = timeline.to_h("event")
    
    return corpse.result

  end

end

class CorpseHttp
  
  attr_accessor :events

  def build

    add_meta("description","A design studio on a sailboat")
    add_meta("keywords","sailing, patreon, indie games, design, liveaboard")
    add_meta("viewport","width=device-width, initial-scale=1, maximum-scale=1")
    add_meta("apple-mobile-web-app-capable","yes")

    add_link("style.reset.css")
    add_link("style.fonts.css")
    add_link("style.main.css")

  end
  
  def body
    
    html = ""
    
    logo = "<div id='logo' style='width:120px;height:120px; margin:15vh auto; background:none'></div>
    <script type='text/javascript' charset='utf-8' src='public.hundredrabbits/scripts/drool.js'></script>"

    menu = "<c class='menu'><a href='#map'>View Map</a> <a href='https://hundredrabbits.itch.io' target='_blank'>Games</a> <a href='https://www.youtube.com/playlist?list=PLV-JXZPiMUdtBGYfvbp9M7N0Tc15GMqy1' target='_blank'>Videos</a></c>"
    
    html += Google_Map.new(events).to_s
    html += "<overlay>#{logo}#{menu}#{status}#{timeline}</overlay>"
    
    return html
    
  end
  
  def status

    html = ""

    distance = 0
    expenses = 0

    @events.each do |date,event|
        if event.type == "sail" then distance += event.value.to_f end
        if event.type == "expense" then expenses += event.value.to_f end
    end

    html += "<h2>Sailed #{distance.to_i}nm<small>#{(distance.to_f/@events['2015-11-01'].offset_months.to_f).to_i}nm per month</small></h2> <h2>Spent #{format_money(expenses.to_i * -1)}<small>#{format_money((expenses.to_i * -1)/@events['2015-11-01'].offset_months)} per month</small></h2><hr/>"

    return " <c class='status'><w>#{html}</w></c>"

  end
  
  def format_money int

    int = "#{int}"
    return "#{int[0,int.length-3]}'#{int[-3,3]}$"

  end
  

  def timeline
  
    html = ""
  
    count = 0
    @events.sort_by{|k,to_i,v| k}.reverse.each do |date,event|
        if event.type == "hidden" then next end
        event.addClass( (count % 2 == 0) ? "odd" : "even" )
        html += event.template
        count += 1
    end
  
    html += "<center></center>"
  
    return " <c class='timeline'>#{html}</c>"
  
  end

end