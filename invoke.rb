#!/bin/env ruby
# encoding: utf-8

$nataniev.require("corpse","http")

$nataniev.vessels[:hundredrabbits].path = File.expand_path(File.join(File.dirname(__FILE__), "/"))
$nataniev.vessels[:hundredrabbits].install(:custom,:serve,CorpseHttp.new)

corpse = $nataniev.vessels[:hundredrabbits].corpse

def corpse.build

  @host = $nataniev.vessels[:hundredrabbits]

  add_meta("description","A design studio on a sailboat")
  add_meta("keywords","sailing, patreon, indie games, design, liveaboard")
  add_meta("viewport","width=device-width, initial-scale=1, maximum-scale=1")
  add_meta("apple-mobile-web-app-capable","yes")

  add_link("reset.css",:lobby)
  add_link("font.input_mono.css",:lobby)
  add_link("font.alte_haas.css",:lobby)
  add_link("style.main.css")

  @title = "Hundred Rabbits"

end

def corpse.query q = nil

  load_folder("#{@host.path}/objects/*")
  
  @timeline = Memory_Hash.new("timeline",@host.path)
  @events = @timeline.to_h("event")

end

def corpse.body

  distance = 0
  expenses = 0

  @events.each do |date,event|
    if event.type == "sail" then distance += event.value.to_f end
    if event.type == "expense" then expenses += event.value.to_f end
  end

  html = ""

  timeline_html = ""
  count = 0
  @events.sort_by{|k,to_i,v| k}.reverse.each do |date,event|
    if event.type == "hidden" then next end
    event.addClass( (count % 2 == 0) ? "odd" : "even" )
    timeline_html += event.template
    count += 1
  end
  timeline_html = " <c class='timeline'>#{timeline_html}</c>"

  html += "
  #{Google_Map.new(events)}
  <overlay>
    <div id='logo' style='width:120px;height:120px; margin:15vh auto; background:none'></div>
    <script type='text/javascript' charset='utf-8' src='public.hundredrabbits/scripts/drool.js'></script>
    <c class='menu'>
      <a href='#map'>View Map</a> 
      <a href='https://hundredrabbits.itch.io' target='_blank'>Games</a> 
      <a href='https://www.youtube.com/channel/UCzdg4pZb-viC3EdA1zxRl4A' target='_blank'>Videos</a> 
      <a href='https://patreon.com/100' target='_blank'>Support Us</a>
    </c>
    <c class='status'>
      <w>
        <h2>Sailed #{distance.to_i}nm</h2> 
        <h2>Spent #{format_money(expenses.to_i * -1)}</h2>
        <hr/>
      </w>
    </c>
    #{timeline_html}
  </overlay>"
  
  return html

end

def corpse.format_money int

  int = "#{int}"
  return "#{int[0,int.length-3]}'#{int[-3,3]}$"

end

class Media
  def path; return "#{$nataniev.path}/public/public.hundredrabbits/media" ; end
end

class ActionGet_location

  include Action

  def act q = "Home"

    load_folder("#{@host.path}/objects/*")
    Memory_Hash.new("timeline",@host.path).to_h("event").each do |date,event|
      if !event.type then next end
      if !event.type.like("sail") then next end
      return event.title
    end
    return "Unknown Location"

  end

end

class ActionGet_position

  include Action

  def act q = "Home"

    load_folder("#{@host.path}/objects/*")
    Memory_Hash.new("timeline",@host.path).to_h("event").each do |date,event|
      if !event.type then next end
      if !event.type.like("sail") then next end
      return event.geolocation.last
    end
    return "Unknown Location"

  end

end

$nataniev.vessels[:hundredrabbits].install(:custom,:get_location,CorpseBase.new)
$nataniev.vessels[:hundredrabbits].install(:custom,:get_position,CorpseBase.new)
