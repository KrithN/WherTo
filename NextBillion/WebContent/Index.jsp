<%@page import="com.move.service.MoveImplement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="initial-scale=1.0" />
<meta charset="UTF-8">
    
<title>WhereTo? Reach places quickly</title>
<link rel="stylesheet" href="css/index.css">
<link href="https://maps-gl.nextbillion.io/maps/v2/api/css" rel="stylesheet"/>
        <script src="https://maps-gl.nextbillion.io/maps/v2/api/js"></script>
</head>


<body background="Images/background1.png">

<jsp:include page="Header.jsp"/>

<form action="MoveController" method="post">
<input type="text" id="whereTo" placeholder="Where to?" name="destination">
<button type="submit" name="butn" id="go" value="Go"> Go</button>
</form>




<div class="split">
 <div class="divScroll">
	<table class="centerA" id="messages">		
		<% 
		
		//String titleSession= request.getAttribute("title").toString();
		 String str[] = (String[]) request.getAttribute("title"); 

		 if(str != null) {
			 for (int i=0; i<str.length;){	 
		%>
		
		<tr>
			<td> <button id="pads" type="button" onclick="getMap(<%=str[i+1]%>)"> <%= str[i] %></button> </td>
		</tr>
		<%i+=2; } }%>
</table>
</div>


  <div class="columnA" id="map"></div>
  
  </div>  
  
    <script>
      function getMap(x,y,destination) {
    	  
    	  let a, b;
    	  a=x;
    	  b=y;
  	    let outDistance, outDuration;
		let apiKey='';
  	 
    	  
    	  var xmlHttp = new XMLHttpRequest();
    	    
    	    xmlHttp.open( "GET", 'https://api.nextbillion.io/directions/json?key='+apiKey+'&origin=13.0040,77.6490&destination='+x+','+y+'&geometry=polyline&mode=4w&overview=full&steps=true', false ); // false for synchronous request
    	    xmlHttp.send( null );  
    	    var response =xmlHttp.responseText;
    	    var json = JSON.parse(response);
    	    let distance=[];
    	    let duration=[];
    	    
    	    var routes = json.routes;
    	    
    	    for(i=0; i<routes.length; i++){
    	    	distance[i]=routes[i].distance;
    	    	duration[i]=routes[i].duration;
    	    	outDistance=(distance[i]/1000).toFixed(2);
    	    	outDuration=(duration[i]/60).toFixed(2)
    	    	console.log((distance[i]/1000).toFixed(2)+' km', (duration[i]/60).toFixed(2) +' minutes');
    	    	
    	    }
        //To use NextBillion Maps GL, an apiKey is required.
        nextbillion.setApiKey(apiKey)
        var nbmap = new nextbillion.maps.Map({
          container: document.getElementById('map'),
          style: "https://api.nextbillion.io/maps/streets/style.json",
          zoom: 12,
          center: { lat: 13.02756, lng: 77.63253 }
        })

        
        // Set the Destination Marker
            const popup = new nextbillion.maps.Popup({
              offset: 25,
              closeButton: false
            }).setText(""+destination);
            const marker = new nextbillion.maps.Marker()
              .setLngLat({lat: x, lng: y})
              .setPopup(popup)
              .addTo(nbmap.map);
            marker.togglePopup();
          
            
        // Set the Origin Marker
            const popupA = new nextbillion.maps.Popup({
                offset: 25,
                closeButton: false
              }).setText("You are here. "+"\n Distance: "+ outDistance+"km"+'\n ETA: '+outDuration+'min');
              const markerA = new nextbillion.maps.Marker()
              .setLngLat({lat: 13.02756, lng: 77.63253})
                .setPopup(popupA)
                .addTo(nbmap.map);
              markerA.togglePopup();
  	  
                            
             
              
              console.log('Before x,y'+x+'---'+y);
              

              // ignore  the 'X' mark as the code is fine

             
             nbmap.on("load", function getMap () {
                 console.log('After x,y'+x+'---'+y);

                 const directionsService = new nextbillion.maps.DirectionsService();
                 directionsService
                 .route({
                   origin: { lat: 13.02756, lng: 77.63253 },
                   destination: {lat: a, lng: b}
                 })
                 
             .then((response) => {
               nbmap.map.addSource("route", {
                 type: "geojson",
                 data: {
                   type: "Feature",
                   properties: {},
                   geometry: {
                     type: "LineString",
                     coordinates: nextbillion.utils.polyline
                       .decode(response.routes[0].geometry, 6)
                       .map((c) => c.reverse())
                   }
                 }
               });
               nbmap.map.addLayer({
                 id: "route",
                 type: "line",
                 source: "route",
                 layout: {
                   "line-join": "round",
                   "line-cap": "round"
                 },
                 paint: {
                   "line-color": "#33D4FF",
                   "line-width": 8
                 }
               });
             });
        
              });
        
      };
      
    </script>
</body>
</html>