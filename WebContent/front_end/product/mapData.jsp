<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
#map {
 
  height: 100%;
}

/* Optional: Makes the sample page fill the window. */
html,
body {
  height: 100%;
  margin: 0;
  padding: 0;
}

#floating-panel {
  position: absolute;
  top: 10px;
  left: 25%;
  z-index: 5;
  background-color: #fff;
  padding: 5px;
  border: 1px solid #999;
  text-align: center;
  font-family: "Roboto", "sans-serif";
  line-height: 30px;
  padding-left: 10px;
}


</style>
<meta charset="Utf">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script>

</head>
  <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <link rel="stylesheet" type="text/css" href="./style.css" />
    <script src="./index.js"></script>
  </head>
  <body>
  
    <div id="floating-panel">
      <input id="hide-markers" type="button" value="Hide Markers" />
      <input id="show-markers" type="button" value="Show Markers" />
      <input id="delete-markers" type="button" value="Delete Markers" />
      <input style="color:red" class="submit1" type="button" value="提交" />
      <form class="form1"action="/TFA104G1/MapServelt">
		<input class="latInput" name="lat" type="hidden" value=""> <input
			class="lngInput" name="lng" type="hidden" value=""> 
			<input class="address" name="address"type="hidden" value="">
			<input type="hidden" name="action" value="dataMap">
			 
	</form>
      <table  style="border:3px #cccccc solid;text-align: center;" cellpadding="10" border='1'>
		<tr>
			<td>經度</td>
			<td>緯度</td>
			<td>地址</td>
		</tr>
		<tr>
			<td class="latTd"></td>
			<td class="lngTd"></td>
			<td class="address"></td>
		</tr>
	</table>
    </div>
    
    <div id="map"></div>
    
   	    

    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDyvYui5OBhj7sjRtoRzCGq4XJtZxLrHM0&callback=initMap&v=weekly"
      async
    ></script>

	
	
	
	<script type="text/javascript">
	let map;
	let markers = [];

	function initMap() {
	  const haightAshbury = { lat: 25.0521328, lng: 121.5410642 };
	  geocoder = new google.maps.Geocoder();
	  popup = new google.maps.InfoWindow();
	  map = new google.maps.Map(document.getElementById("map"), {
	    zoom: 14,
	    center: haightAshbury,
	    mapTypeId: "terrain",
	  });
	  // This event listener will call addMarker() when the map is clicked.
	  map.addListener("click", (event) => {
	    addMarker(event.latLng);
	  });
	  // add event listeners for the buttons
	  document
	    .getElementById("show-markers")
	    .addEventListener("click", showMarkers);
	  document
	    .getElementById("hide-markers")
	    .addEventListener("click", hideMarkers);
	  document
	    .getElementById("delete-markers")
	    .addEventListener("click", deleteMarkers);
	  // Adds a marker at the center of the map.
	  addMarker(haightAshbury);
	}

	// Adds a marker to the map and push to the array.
	function addMarker(position) {
	  const marker = new google.maps.Marker({
	    position,
	    map,
	    
	  });
	  geocoder.geocode({
          'latLng': position
        }, function(results, status) {
            if (status === google.maps.GeocoderStatus.OK) {
                if (results) {
                    // 將取得的資訊傳入 marker 訊息泡泡
                    showAddress(results[0], marker);
                }
            } else {
                alert("Reverse Geocoding failed because: " + status);
            }
        });
	  
	  
	  
	  hideMarkers();
	  markers = [];
	  markers.push(marker);
	  var str = JSON.stringify(position);
// 	  console.log(JSON.stringify(position));


	  console.log("lat "+JSON.parse(str).lat);
	  console.log("lng "+JSON.parse(str).lng);
	  $('td.latTd').text(JSON.parse(str).lat);
		$('td.lngTd').text(JSON.parse(str).lng);
		$('input.latInput').val(JSON.parse(str).lat);
		$('input.lngInput').val(JSON.parse(str).lng);
	  	
	}
	
	

	// Sets the map on all markers in the array.
	function setMapOnAll(map) {
	  for (let i = 0; i < markers.length; i++) {
	    markers[i].setMap(map);
	  }
	}

	// Removes the markers from the map, but keeps them in the array.
	function hideMarkers() {
	  setMapOnAll(null);
	}

	// Shows any markers currently in the array.
	function showMarkers() {
	  setMapOnAll(map);
	}

	// Deletes all markers in the array by removing references to them.
	function deleteMarkers() {
	  hideMarkers();
	  markers = [];
	}
	
	
	function showAddress(result, marker) {
        map.setCenter(marker.getPosition());
        // 顯示傳入的地址資訊
        var popupContent = '<b>地址: </b> ' + result.formatted_address;
        popup.setContent(popupContent);
        popup.open(map, marker);
        $('td.address').text(result.formatted_address);
        $('input.address').val(result.formatted_address);
    }
	
	</script>
	
	
	
</body>




	
<script type="text/javascript">
	if (navigator.geolocation) {

		// 使用者不提供權限，或是發生其它錯誤
		function error() {
			alert('無法取得你的位置');
		}

		// 使用者允許抓目前位置，回傳經緯度
		function success(position) {
			console.log(position.coords.latitude, position.coords.longitude);
			
			
		}

		// 跟使用者拿所在位置的權限
		navigator.geolocation.getCurrentPosition(success, error);

	} else {
		alert('Sorry, 你的裝置不支援地理位置功能。')
	}
	
	
	
	$("input.submit1").click(function(){
		$("form.form1").submit();
	});
</script>
</html>