<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="Utf-8"%>
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
   <p><input id="addr" placeholder="台北火車站">
         <button id="query">查詢</button></p>
      <p>緯度：<span id="lat">25.0479</span> 
         經度：<span id="lng">121.5170</span></p>
      <div id="map" style="width:400px; height:300px"></div>
  
   <script src="http://maps.googleapis.com/maps/api/js?key=AIzaSyDyvYui5OBhj7sjRtoRzCGq4XJtZxLrHM0&callback=initMap"></script>
    <script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
    <script>
    $(function(){
      // 建立 Geocoder() 物件
      var gc = new google.maps.Geocoder();
      var mymap = new google.maps.Map($('#map').get(0), {
                zoom: 15,
                center: {lat:25.0479, lng:121.5170}
      });
            
      // 設定查詢按鈕的事件處理函式
      $('#query').click(function(){
        // 取得使用者輸入的地址
        var addr = $('#addr').val();
        if(addr=='') return; // 若為空字串則返回
        
        // 用使用者輸入的地址查詢
        gc.geocode({'address': addr}, function(result, status){
          // 確認 OK
          if(status == google.maps.GeocoderStatus.OK) {
            var latlng = result[0].geometry.location;
            //  取得查詢結果第0筆中的經緯度物件
            mymap.setCenter(latlng); //將查詢結果設為地圖的中心
            $('#lat').text(latlng.lat()); //顯示經度
            $('#lng').text(latlng.lng()); //顯示緯度
          }
        }); 
      });  // END of click()
      
      // 設定輸入欄位按鍵放開的事件處理函式
      $('#addr').keyup(function(event){
        if(event.keyCode == 13) // 若是按下/放開 Enter 鍵 
          $('#query').click();
      });  // END of keyup()
    });
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