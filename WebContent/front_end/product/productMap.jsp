<!DOCTYPE html>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<html>
  <head>
    <title>Simple Map</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <link rel="stylesheet" type="text/css" href="./style.css" />
    <script src="./index.js"></script>
  </head>
  <style>

#map {
  height: 500px;
  width:700px;
}

/* Optional: Makes the sample page fill the window. */
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
}
  
  </style>
  <script type="text/javascript">
  let map;
  
  function initMap() {
    map = new google.maps.Map(document.getElementById("map"), {
      center: { lat: 25.0374865, lng: 121.5647688 },
      zoom: 16,
    });
    
   var marker = new google.maps.Marker({
	  position:{lat:25.0031362,lng:121.4418813},
	  map:map
   });
   var marker = new google.maps.Marker({
		  position:{lat:25.0031362,lng:121.4418813},
		  map:map
	   });
   
    
    
    
  }
  </script>
  <body>
    <div id="map"></div>

    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDyvYui5OBhj7sjRtoRzCGq4XJtZxLrHM0&callback=initMap&v=weekly"
      async
    ></script>
  </body>
</html>