var like = 0;




$(function () {
    //alert("지도 실행");
    var long = $('#longitude_t').text();
    var la = $('#latitude_t').text();
    var address = $('#address_t').text();
     var keyword = $('#keyword').text();
    //alert(keyword);
    //alert(address);
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new daum.maps.Map(mapContainer, mapOption); 

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new daum.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addr2coord(address, function(status, result) {

    // 정상적으로 검색이 완료됐으면 
     if (status === daum.maps.services.Status.OK) {

        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new daum.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new daum.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+keyword+'</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    }else{
        
        alert("실패");
        var infowindow = new daum.maps.InfoWindow({zIndex:1});
        // 장소 검색 객체를 생성합니다
    var ps = new daum.maps.services.Places(); 

    // 키워드로 장소를 검색합니다
    ps.keywordSearch(address, placesSearchCB); 
        var ps = new daum.maps.services.Places(); 

// 키워드로 장소를 검색합니다
ps.keywordSearch(keyword, placesSearchCB); 

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (status, data, pagination) {
    if (status === daum.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new daum.maps.LatLngBounds();

        for (var i=0; i<data.places.length; i++) {
            displayMarker(data.places[i]);    
            bounds.extend(new daum.maps.LatLng(data.places[i].latitude, data.places[i].longitude));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    
    // 마커를 생성하고 지도에 표시합니다
    var marker = new daum.maps.Marker({
        map: map,
        position: new daum.maps.LatLng(place.latitude, place.longitude) 
    });

    // 마커에 클릭이벤트를 등록합니다
    daum.maps.event.addListener(marker, 'click', function() {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.title + '</div>');
        infowindow.open(map, marker);
    });
}
        
        
    } 
});


    
    
    
    
    
    $('#sandbox-container .input-group.date').datepicker({
            startDate: "today",
            format: 'yyyy/mm/dd',
            language: "kr",
            orientation: "bottom left",
            autoclose: true,
            todayHighlight: true
         
            
            
        });
     

});

function like_click(program_name,category) {
    
    $('#like').toggleClass('glyphicon glyphicon-heart-empty pcitogram').toggleClass('glyphicon glyphicon-heart pcitogram_full_heart');
    if(like==0){ //좋아요 올라가는거!
        like=1;
        var pre_data = parseInt(document.getElementById("like_count").innerHTML);
        document.getElementById("like_count").textContent= pre_data + 1;
        if(category=='mountain_program'){
         
           $.ajax({
              type:"GET",
              url:"/program_likeup",
              dataType:"json",
              data: {p_name: program_name},
              success:function(result){
                
              }
            }); 
        }
        else{
           $.ajax({
              type:"GET",
              url:"/like",
              dataType:"json",
              data: {p_name: program_name},
              success:function(result){
                
              }
            });
        }
        
        
    }else{ // 좋아요 취소
        like=0;
        var pre_data = parseInt(document.getElementById("like_count").innerHTML);
        document.getElementById("like_count").textContent= pre_data - 1;
        if(category=='mountain_program'){
            $.ajax({
              type:"GET",
              url:"/program_likedown",
              dataType:"json",
              data: {p_name: program_name},
              success:function(result){
                
              }
            }); 
        }
        else{
           $.ajax({
              type:"GET",
              url:"/nonlike",
              dataType:"json",
              data: {p_name: program_name},
              success:function(result){
                
              }
            });
        }
        
        
        
    }

    
    
} 







