<%@page import="java.util.List"%>
<%@page import="com.product.model.*"%>
<%@page import="java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>product-map</title>
    <link rel="canonical" href="https://letswrite.tw/google-map-api-distance-matrix/">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
      .container1 {
        padding-top: 30px;
        padding-bottom: 30px;
      }
      #map {
        background: #CCC;
        height:500px;
      }
      ul {
        padding-top: 16px;
      }
      .media img {
        max-width: 64px;
      }
      .media h5, p {
        font-size: 14px;
      }
      .mdeia p {
        margin-bottom: 6px;
      }
      .media h6 {
        font-size: 12px;
        color: #CCC;
      }
      .fixed-bottom {
        position: fixed;
        left: 16px;
        bottom: 0;
        max-width: 320px;
      }
    </style>

    <!-- <link rel="shortcut icon" href="https://letswritetw.github.io/letswritetw/dist/img/logo_512.png"/> -->
    <!-- Google Tag Manager-->

  </head>
  <body>
  <link href="<%=request.getContextPath()%>/includeFolder/css/font-awesome.css" rel="stylesheet">
  <!-- Bootstrap -->
  <link href="<%=request.getContextPath()%>/includeFolder/css/bootstrap.css" rel="stylesheet">
  <!-- SmartMenus jQuery Bootstrap Addon CSS -->
  <!-- Product view slider -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/includeFolder/css/jquery.simpleLens.css">
  <!-- slick slider -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/includeFolder/css/slick.css">
  <!-- price picker slider -->
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/includeFolder/css/nouislider.css">
  <!-- Theme color -->
  <link id="switcher" href="<%=request.getContextPath()%>/includeFolder/css/theme-color/dark-navy-theme.css" rel="stylesheet">
  <!-- <link id="switcher" href="<%=request.getContextPath()%>/includeFolder/css/theme-color/bridge-theme.css" rel="stylesheet"> -->
  <!-- Top Slider CSS -->
  <link href="<%=request.getContextPath()%>/includeFolder/css/sequence-theme.modern-slide-in.css" rel="stylesheet" media="all">

  <!-- Main style sheet -->	
 <link href="<%=request.getContextPath()%>/includeFolder/css/style copy.css" rel="stylesheet">


  <!-- Google Font -->
  <link href='https://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Raleway' rel='stylesheet' type='text/css'>
<script src="<%=request.getContextPath()%>/jquery-3.6.0.min.js"></script>
</head>

<body>

  </div>
  <a class="scrollToTop" href="#"><i class="fa fa-chevron-up"></i></a>
  <!-- END SCROLL TOP BUTTON -->
  <!-- Start header section -->
  <header id="aa-header">
    <!-- start header top  -->
    <div class="aa-header-top">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="aa-header-top-area">
              <!-- start header top left -->
              <div class="aa-header-top-left">
                <p style="font-size: 20px; margin:0;font-weight:normal;">JoyLease</p>
              </div>
              <!-- Navbar -->
              <div class="aa-header-top-right">
       
            
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- / header top  -->
    <!-- start header bottom  -->
    <div class="aa-header-bottom">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <div class="aa-header-bottom-area">
              <div class="aa-logo">
                  <a href="<%=request.getContextPath()%>/front_end/product/homePage.jsp">
                  <img src="<%=request.getContextPath()%>/includeFolder/img/logo_org_noframe_191561.png" alt="">
                </a>
              </div>
              <!--  cart box -->
            <%@ include file="/includeFolder/cartInclude.file" %> 
              <!-- / cart box -->
              <!-- search box -->
              <div class="aa-search-box">
                 <form class="" action="<%=path %>/prod/ProdServlet" method="post">
                <input type="text" name="searchCot" id="" placeholder="健身環大冒險">
                  <input type="hidden" name="action" value="search">
                  <button type="submit"><span class="fa fa-search"></span></button>
                </form>
              </div>
              <!-- / search box -->
            </div>
          </div>
        </div>
      </div>
    </div>
    <!-- / header bottom  -->
 
  <section id="menu">
    <div class="container">
      <div class="menu-area">
        <!-- Navbar -->
        <div class="navbar navbar-default" role="navigation">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
         
        </div>
      </div>
    </div>
  </section>
  
  
  
  
    <!-- Google Tag Manager (noscript)-->
    <noscript>
      <iframe src="https://www.googletagmanager.com/ns.html?id=GTM-PGQ9WQT" height="0" width="0" style="display:none;visibility:hidden"></iframe>
    </noscript>

    

    <div id="app" class="container1">

      <!-- 找目前地點 -->
      <section class="row">
        <div class="col google-map">
          <form class="form_search" action="/TFA104G1/MapServelt">
          <br><br>
          商品搜尋:
          
          <input type="hidden" name="action" value="search">
          <input type="text" class="search" name=search>
          <input class ="search-btn"type="submit">
        </form>
        </div>
      </section>

      <hr>

      <section class="row">

        <!-- google map -->
        <div class="col-md-8 google-map">
          <div id="map" class="embed-responsive embed-responsive-16by9"></div>
        </div>

        <!-- 顯示距離列表 -->
        <div class="col-md-4">
		<button type="button" class="btn btn-info" @click="getCurrent">找目前位置與地圖上地點的距離</button>
          <div class="list-group">
            <div v-for="f in features" class="list-group-item">
            <a class="prod_a" :href="f.properties.url">商品編號{{ f.properties.id}}
              <div class="d-flex w-100 justify-content-between">
                <h5 class="mb-1">{{ f.properties.name }}</h5><br>
                <h5 class="mb-1">{{ f.properties.productName }}</h5>
                <small>{{ f.properties.distance_text }}</small>
              </div></a>
              <p class="mb-1">{{ f.properties.site }}</p>
              <small>{{ f.properties.distance_time }}</small>
            </div>
          </div>

        </div>
        
      </section>

    </div>
    
    <!-- 將 YOUR_API_KEY 替換成你的 API Key 即可 -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDyvYui5OBhj7sjRtoRzCGq4XJtZxLrHM0"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.6.10/vue.min.js"></script>

    <!-- map -->
    <script>

    
      const googleMap = new Vue({
        el: '#app',
        data: {
          map: null,
          features: [] // 放地圖上的5個點
        },
        methods: {
          // init google map
          initMap() {
            
            // 預設地圖中心點
            let location = {
              lat: 25.0521328,
              lng: 121.5410642
            };

            this.map = new google.maps.Map(document.getElementById('map'), {
              center: location,
              zoom: 16
            });
            let marker = new google.maps.Marker({
        position: location,
        title: '自己',
        map: this.map
      });
          

            
            // 放置marker
            fetch('/TFA104G1/MapServelt?action=getMapData')
              .then(res => res.json())
              .then(result => {
                this.features = result.features;
                // this.features = vicDummyDatas;
                


              
                Array.prototype.forEach.call(this.features, r => {

                  
                  // 寫入marker
                  let latLng = new google.maps.LatLng(r.geometry.coordinates[0], r.geometry.coordinates[1]);
                  let marker = new google.maps.Marker({
                    position: latLng,
                    map: this.map,
                    site:r.properties.site,
                    prodID:r.properties.id,
                    icon: 'https://cdn0.iconfinder.com/data/icons/lumin-social-media-icons/512/Location-32.png'
                  });

                  // marker 的泡泡框
                  let infowindow = new google.maps.InfoWindow({
                    content: `<p>${r.properties.name}</p>` // 支援html
                  });
				console.log($('a.prod_a'));
                 
				marker.addListener("click", () => {
                      console.log(marker.prodID);
                      window.location.assign("/TFA104G1/front_end/product/prodDetail.jsp?prodID="+marker.prodID);
                      
                      
                   });



                  marker.addListener("mouseover", () => {
                    
                    $('div.list-group').css("backgroundColor","yellow");
                      console.log(marker.site)
                    // for(var i=0;i<$('p.mb-1').length;i++){
                      $('p.mb-1').each(function(){
                        // console.log($(this).text())
                     
                    // }
                    if(marker.site==$(this).text()){
                      console.log($(this).text())
                      console.log($(this).closest('div.list-group-item'))
                      $(this).closest('div.list-group-item').css("backgroundColor","yellow")
                      // console.log($('p.mb-1').closest('section').find('div.list-group'));
                      // alert(r?.properties?.site);
                    }
                  });
                   });
                  
                   marker.addListener("mouseout", () => {
                  
                    // alert(r?.properties?.site);
                   
                    $('p.mb-1').each(function(){
                        // console.log($(this).text())
                     
                    // }
                    if(marker.site==$(this).text()){
                      console.log($(this).text())
                      console.log($(this).closest('div.list-group-item'))
                      $(this).closest('div.list-group-item').css("backgroundColor","white");
                      // console.log($('p.mb-1').closest('section').find('div.list-group'));
                      // alert(r?.properties?.site);
                    }
                  });
                    
                   });
                   

                });
              })

          },
          // 抓使用者所在位置
          getCurrent() {

            const _this = this;

            // 先確認使用者裝置能不能抓地點
            if(navigator.geolocation) {

              // 使用者不提供權限，或是發生其它錯誤
              function error() {
                alert('無法取得你的位置');
              }

              // 使用者允許抓目前位置，回傳經緯度
              function success(position) {
              //   lat: 25.0521328,
              // lng: 121.5410642
                // 將所在地設成比較的點
                let originPosition = new google.maps.LatLng(25.0521328,121.5410642);

                // 把要計算的點存成陣列
                let destinations = [];
                Array.prototype.forEach.call(_this.features, f => {
                  destinations.push(new google.maps.LatLng(f.geometry.coordinates[0], f.geometry.coordinates[1]));
                });

                // 所在位置跟各點的距離
                const service = new google.maps.DistanceMatrixService();
                service.getDistanceMatrix({
                  origins: [originPosition],
                  destinations: destinations,
                  travelMode: 'WALKING', // 交通方式：BICYCLING(自行車)、DRIVING(開車，預設)、TRANSIT(大眾運輸)、WALKING(走路)
                  unitSystem: google.maps.UnitSystem.METRIC, // 單位 METRIC(公里，預設)、IMPERIAL(哩)
                  avoidHighways: true, // 是否避開高速公路
                  avoidTolls: true // 是否避開收費路線
                }, callback);
                function callback(response, status) {
                  console.log(response);
                  // 把距離寫進json裡
                  for(let i = 0, len = _this.features.length; i < len; i++) {
                    _this.features[i].properties.distance = response.rows[0].elements[i].distance.value;
                    _this.features[i].properties.distance_text = response.rows[0].elements[i].distance.text;
                    _this.features[i].properties.distance_time = response.rows[0].elements[i].duration.text;
                  }
                  // 按距離重排
                  _this.features = _this.features.sort((a, b) => {
                    return a.properties.distance > b.properties.distance ? 1 : -1;
                  });
                  console.log(_this.features);
                }
              }

              // 跟使用者拿所在位置的權限
              navigator.geolocation.getCurrentPosition(success, error);

            } else {
              alert('Sorry, 你的裝置不支援地理位置功能。');
            }
          }
        },
        mounted() {
          window.addEventListener('load', () => {
            this.initMap();
          });
        }
      })

      $('input.search-btn').click(function(){
        
        if($('input.search').val()==""){
          alert('請輸入搜尋內容');
          return false;
        }
      });
    </script>

  </body>
</html>
