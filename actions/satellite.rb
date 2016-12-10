#!/bin/env ruby
# encoding: utf-8

class ActionSatellite

  include Action
  
  def initialize q = nil

    super

    @name = "Satellite"
    @docs = "Save satellite position from Iridium mail."

  end

  def act q = "Home"

    # example query: satellite Lat48deg7302220Lon-123deg2752220Alt167ft20GPS20Sats20seen:2009202016-08-122004:38UTC20http:map.iridium.commlat48.125010lon-123.45153220Sent20via20Iridium20GO

    if !q.include?("http:map.iridium.comm") then return "Error" end

    q = q.split("http:map.iridium.comm").last.split("Sent").first

    lat = q.split("lon").first.sub("lat","")
    lon = q.split("lon").last

    lat = lat.to_f
    lon = lon.to_f

    insert("2016-08-11",lat,lon) # Target event TODO

    return q

  end

end
