class Layout

    def page_sailboat

    	return "
        <c class='sailboat'>
        <img class='main' src='files/sailboat.main.jpg'/>
        <w>
            #{overview}
        </w>
        </c>"

    end

    def overview

        return "<p class='main'>Our vessel is a 33' Yamaha Sloop, built in 1982. It is ocean ready and sleeps 5 passengers comfortably.</p>
        <p>We maintain an updated <a href='https://github.com/hundredrabbits/Yamaha-33/blob/master/README.md' target='_blank'>spec sheet</a> with technical details.</p>

        <img src='files/sailboat.studio.2.jpg'/>

        <table>
            <tr><th>Make</th><td>Yamaha</td><th>Year</th><td>1982</td></tr>
            <tr><th>Length</th><td>33.0ft(10.16m)</td><th>Engine</th><td>Yanmar 12HP</td></tr>
            <tr><th>Hull</th><td>Fiberglass</td><th>Keel</th><td>Fin</td></tr>
            <tr><th>Draft</th><td>6.25ft(1.91m)</td><th>Height</th><td>50.00ft</td></tr>
        </table>

        <img src='files/sailboat.studio.1.jpg'/>

        "
    end

    def sponsors

        return "<h2>Sponsors</h2>
        <ul class='default'>
            <li><a href='https://twitter.com/scottstevenson' target='_blank'>Scott Stevenson</a>, for the plane tickets</li>
            <li><a href='http://www.robocutstudio.com' target='_blank'>Robocut Studio</a>, for the plaque</li>
            <li><a href='http://xc3n.net' target='_blank'>Francis Yoan Rodrigues</a>, for the new VHF</li>
            <li><a href='http://twitter.com/Transceiverfreq' target='_blank'>Transceiverfreq</a>, for the patches</li>
            <li><a href='https://www.patreon.com/100' target='_blank'>All our patrons</a>, for their constant support</li>
        </ul>
        "

    end

end