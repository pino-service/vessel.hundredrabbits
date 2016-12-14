#: The graph object creates the Horaire previews.

class Graph

	def initialize(logs)
		@logs = logs
		@segments = equalSegments
		@sumHours = 0
	end

	def segmentMemory

		memory = []
		segments_limit = 28
		i = 0
		while i < 28
			memory[i] = {}
			memory[i]["patrons"] = 0
			memory[i]["pledged"] = 0
			memory[i]["average"] = 0
			i += 1
		end
		return memory

	end

	def offset elapsed

		timeDiff = (elapsed/86400)

		if timeDiff < -1 then return "In "+(timeDiff*-1).to_s+" days" end
		if timeDiff == -1 then return "tomorrow" end
		if timeDiff == 0 then return "today" end
		if timeDiff == 1 then return "yesterday" end
		if timeDiff == 7 then return "a week ago" end
		if timeDiff > 740 then return (timeDiff/30/12).to_s+" years ago" end
		if timeDiff > 60 then return (timeDiff/30).to_s+" months ago" end
		if timeDiff > 30 then return "a month ago" end

		return timeDiff.to_s+" days ago"
	end

	def equalSegments

		segments = segmentMemory

		@from = @logs.first['elapsed']
		@to = @logs.last['elapsed']
		@length = @to - @from

		@logs.each do |log|
			progressFloat = (log['elapsed']/@to.to_f) * 28
			progressPrev = progressFloat.to_i
			progressNext  = progressFloat.ceil
			distributePrev = progressNext - progressFloat
			distributeNext = 1 - distributePrev

			patrons_count = log["patrons"].to_f
			patrons_pledged = log["pledged"].to_f
			patrons_average = (patrons_pledged/patrons_count) * 40

			if segments[progressPrev] then segments[progressPrev]["patrons"] += patrons_count * distributePrev end
			if segments[progressNext] then segments[progressNext]["patrons"] += patrons_count * distributeNext end

			if segments[progressPrev] then segments[progressPrev]["pledged"] += patrons_pledged * distributePrev end
			if segments[progressNext] then segments[progressNext]["pledged"] += patrons_pledged * distributeNext end

			if segments[progressPrev] then segments[progressPrev]["average"] += patrons_average * distributePrev end
			if segments[progressNext] then segments[progressNext]["average"] += patrons_average * distributeNext end
		end
		
		return segments

	end

	def findHighestValue

		highest = 1
		@segments.each do |values|
			if values["pledged"] > highest then highest = values["pledged"]end
		end
		return highest

	end

	def draw

		html = ""
		width = 450
		height = 150
		lineWidth = 660/28
		segmentWidth = lineWidth/3
		highestValue = findHighestValue

		linePatrons_html = ""
		linePledged_html = ""
		lineAverage_html = ""

		count = 0
		@segments.reverse.each do |values|
			value = height - ((values["patrons"]/highestValue) * height)
			linePatrons_html += "#{(count * lineWidth + (segmentWidth))},#{(value).to_i} "
			linePatrons_html += "#{(count * lineWidth + (segmentWidth * 3))},#{(value).to_i} "
			value = height - (values["pledged"]/highestValue * height)
			linePledged_html += "#{(count * lineWidth + (segmentWidth))},#{(value).to_i} "
			linePledged_html += "#{(count * lineWidth + (segmentWidth * 3))},#{(value).to_i} "
			value = height - (values["average"]/highestValue * height)
			lineAverage_html += "#{(count * lineWidth + (segmentWidth))},#{(value).to_i} "
			lineAverage_html += "#{(count * lineWidth + (segmentWidth * 3))},#{(value).to_i} "
			count += 1
		end

		# Lines

		html += "<polyline points='#{lineAverage_html}' style='fill:none;stroke:#cccccc;stroke-width:2' stroke-dasharray='2,4' />"
		html += "<polyline points='#{linePledged_html}' style='fill:none;stroke:#76dbe1;stroke-width:2' />"
		html += "<polyline points='#{linePatrons_html}' style='fill:none;stroke:#99b0b1;stroke-width:2' />"

		# Markers

		markers = ""
		markers += "<span style='position:absolute; top:15px;left:0px;'>#{offset(@logs.last['elapsed'])}</span>"
		# markers += "<span style='position:absolute; top:15px;right:15px; text-align:right;'>#{offset(@logs.first['elapsed'])}</span>"

		return "<graph><svg style='width:#{width}px; height:#{height}px;'>"+html+"<svg>#{markers}</graph>"

	end

end

class CircleGraph

	def initialize(logs)
		@logs = logs
		makeSums()
	end

	def makeSums

		@sumAudio = 0
	  	@sumVisual = 0
	  	@sumResearch = 0
	  	@sumAll = 0

	  	@dayAudio = 0
	  	@dayVisual = 0
	  	@dayResearch = 0

	  	$horaire.to_a("log").each do |log|
		    if $page.topic != "Horaire" && log.topic != $page.topic then next end

	  		if log.sector == "audio" then @sumAudio += log.value end
	  		if log.sector == "visual" then @sumVisual += log.value end
	  		if log.sector == "research" then @sumResearch += log.value end

	  		if log.sector == "audio" then @dayAudio += 1 end
	  		if log.sector == "visual" then @dayVisual += 1 end
	  		if log.sector == "research" then @dayResearch += 1 end
	  	end
	  	@sumAll = @sumAudio + @sumVisual + @sumResearch
	  	@sumDays = @dayAudio + @dayVisual + @dayResearch

	end

	def graph

    graph = ""
    strokeWidth = 20
    circleRadius = 15
    circumference = 2 * Math::PI * circleRadius
    graph += "<circle cx='"+circleRadius.to_s+"' cy='"+circleRadius.to_s+"' r='"+circleRadius.to_s+"' stroke='black' stroke-width='#{strokeWidth}' fill='none' />"
    
    # Audio
    strokeLength = (@sumAudio/@sumAll.to_f) * circumference
    strokeRemain = circumference - strokeLength
    
    graph += "<circle cx='"+circleRadius.to_s+"' cy='"+circleRadius.to_s+"' r='"+circleRadius.to_s+"' stroke='#72dec2' stroke-width='1' fill='none' stroke-dasharray='"+strokeLength.to_s+" "+strokeRemain.to_s+"' />"
    
    # Visual
    strokeLength = (@sumVisual/@sumAll.to_f) * circumference
    strokeRemain = circumference - strokeLength
    angle = (@sumAudio/@sumAll.to_f) * 360
    
    graph += "<circle cx='"+circleRadius.to_s+"' cy='"+circleRadius.to_s+"' r='"+circleRadius.to_s+"' stroke='#ff0000' stroke-width='1' fill='none' stroke-dasharray='"+strokeLength.to_s+" "+strokeRemain.to_s+"' transform='rotate("+angle.to_s+" "+circleRadius.to_s+" "+circleRadius.to_s+")' />"
    
    # Research
    strokeLength = (@sumResearch/@sumAll.to_f) * circumference
    strokeRemain = circumference - strokeLength
    angle = ((@sumAudio+@sumVisual)/@sumAll.to_f) * 360
    
    graph += "<circle cx='"+circleRadius.to_s+"' cy='"+circleRadius.to_s+"' r='"+circleRadius.to_s+"' stroke='#fff' stroke-width='1' fill='none' stroke-dasharray='"+strokeLength.to_s+" "+strokeRemain.to_s+"' transform='rotate("+angle.to_s+" "+circleRadius.to_s+" "+circleRadius.to_s+")' />"
    return "<svg style='width:"+(circleRadius*2).to_s+"px; height:"+(circleRadius*2).to_s+"px; padding:#{strokeWidth/2}px;'>#{graph}</svg>"

	end

	def tasks

		html = ""

		tasks = {}

		@logs.each do |log|
			tasks[log.task] = tasks[log.task].to_i + log.value
		end

		tasks.sort_by {|_key, value| value}.reverse.each do |task,value|
			task = "#{task}" == "" ? "Misc" : task
			percent = ((value/@sumAll.to_f)*1000).to_i/10.to_f
			# if percent < 1 then next end
			html += "
			<a class='task'>
				<span class='ratio'>#{percent}%</span>
				<strong>#{task}</strong>
				<span class='hours'>#{value}h</span>
			</a>"
		end

		return "<content class='details'>#{html}</content>"

	end

	def draw

	  	return "<content class='circlegraph'>#{graph}#{tasks}</content>"

	end

end