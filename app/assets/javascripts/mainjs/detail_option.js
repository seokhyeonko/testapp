

//"facility", "facility_name", "address","management_period","tel","join_method","target"
/*
@name = nil
    @state = nil
    @lodage_classification = nil#크기가 2인 배열로 이루어짐
    @size = nil
    @available_people = nil
    @enterence_fee = nil
    @is_stay = nil
    @major_facilities = nil
    @address = nil #도로명 주소
    @management = nil
    @tel = nil
    @homepage_add = nil
    @latitude = nil
    @longitude = nil
    @data_standard_date = nil

*/


function program_footer_clicked(id,json_id,page_num,page_id) {
            
            var content_start =(page_num-1) * 10;
            
            var temp = $("#"+json_id).text();
            temp = temp.toString();
     
            
            //$( "p:first" ).text();
            datajson = JSON.parse(temp)
            var panelid;
      
            //+routing 해주시고
            var htmlresult = "";
            
            
            
            
            
            
            
            switch(json_id){
            
                case "forest_lodge":
                 
                    var count = 0;
                    for(var i=content_start;i<datajson.length;i++){
                        
                        if(count==10) break;
                        count++;
                        var htmldoc = '<div class="panel-body"><div class="data_title"><a href="';
                        htmldoc = htmldoc + '/detail_lodge?name=' + datajson[i].name +"&state=" + datajson[i].state 
                                          + "&lodage_classification=" + datajson[i].lodage_classification +       "&size=" + datajson[i].size
                                          + "&available_people=" + datajson[i].available_people +               "&enterence_fee=" + datajson[i].enterence_fee
                                          + "&is_stay=" + datajson[i].is_stay + "&major_facilities=" + datajson[i].major_facilities
                                          + "&address=" + datajson[i].address + "&management=" + datajson[i].management
                                          + "&tel=" + datajson[i].tel + "&homepage_add=" + datajson[i].homepage_add
                                          + "&latitude=" + datajson[i].latitude + + "&longitude=" + datajson[i].longitude
                                          + "&data_standard_date=" + datajson[i].data_standard_date +'">' + datajson[i].name + '</a>';
                                          
                        htmldoc = htmldoc + '<span>조회수 : 100</span></div><div class="data_meta"><span>기관 : <font style="font-family:sans-serif,Courier;">'; 
                        htmldoc = htmldoc + datajson[i].name + '</font></span><span>장소 :';
                        htmldoc = htmldoc + datajson[i].address + '</span><span>연락처';
                        htmldoc = htmldoc + datajson[i].tel;
                        htmldoc = htmldoc + '</span>'+ '<div class="data_content"><span>휴양림</span></div></div>';
                        
                        if(count==1){
                             $("#"+page_id).html(htmldoc);                 
                        }else{
                             $("#"+page_id).append(htmldoc);
                        }
                        
                  
                    }
                    break;
                case "prenatal":
                    
                    for(var i=content_start;i<i+10;i++){
                        
                        
                        
                        
                    }
                    break;
                case "mountain_explain":
                    alert("숲해설");
                    alert(page_id);
                    var count = 0;
                    for(var i=content_start;i<datajson.length;i++){
                     
                        if(count==10) break;
                         count++;
                        var htmldoc = '<div class="panel-body"><div class="data_title"><a href="';
                        htmldoc = htmldoc + '/detail_explanation?facility=' + datajson[i].facility +"&facility_name=" + datajson[i].facility_name 
                                          + "&address=" + datajson[i].address +       "&management_period=" + datajson[i].management_period
                                          + "&tel=" + datajson[i].tel +               "&join_method=" + datajson[i].join_method
                                          + "&target=" + datajson[i].target + '">' + datajson[i].facility_name + '</a>';
                                          
                        htmldoc = htmldoc + '<span>조회수 : 100</span></div><div class="data_meta"><span>기관 : <font style="font-family:sans-serif,Courier;">'; 
                        htmldoc = htmldoc + datajson[i].facility_name + '</font></span><span>장소 :';
                        htmldoc = htmldoc + datajson[i].address + '</span><span>연락처';
                        htmldoc = htmldoc + datajson[i].tel;
                        htmldoc = htmldoc + '</span>'+ '<div class="data_content"><span>숲 해설 프로그램</span></div></div>';
                        
                        if(count==1){
                             $("#"+page_id).html(htmldoc);                 
                        }else{
                             $("#"+page_id).append(htmldoc);
                        }
                        
                        
                        htmlresult += htmldoc;
                    }
                    break;
                case "mountain_program":
                    
                    for(var i=content_start;i<i+10;i++){
                        
                    }
                    break;
                case "arboretum": 
                    
                    var count=0;
                    for(var i=content_start;i<datajson.length;i++){
                     
                        if(count==10) break;
                         count++;
                        var htmldoc = '<div class="panel-body"><div class="data_title"><a href="';
                        htmldoc = htmldoc + '/detail_arboretum?name =' + datajson[i].name  +"&address=" + datajson[i].address  
                                          + "&size =" + datajson[i].size  +       "&plants_numbers =" + datajson[i].plants_numbers 
                                          + "&start_date =" + datajson[i].start_date  +               "&tel =" + datajson[i].tel 
                                          + "&content  =" + datajson[i].content  + "&homepage_addr  =" + datajson[i].homepage_addr 
                                          + "&related_link  =" + datajson[i].related_link +'">' + datajson[i].name + '</a>';
                                          
                        htmldoc = htmldoc + '<span>조회수 : 100</span></div><div class="data_meta"><span>기관 : <font style="font-family:sans-serif,Courier;">'; 
                        htmldoc = htmldoc + datajson[i].name + '</font></span><span>장소 :';
                        htmldoc = htmldoc + datajson[i].address + '</span><span>연락처';
                        htmldoc = htmldoc + '없음';
                        htmldoc = htmldoc + '</span>'+ '<div class="data_content"><span>식물들을 관찰할 수 있습니다.</span></div></div>';
                        
                        if(count==1){
                             $("#"+page_id).html(htmldoc);                 
                        }else{
                             $("#"+page_id).append(htmldoc);
                        }
                        
                        
                        htmlresult += htmldoc;
                    }
                    break;
                case "ecovilage": 
                    
                    var count = 0;
                    for(var i=content_start;i<datajson.length;i++){
                     
                        if(count==10) break;
                         count++;
                        var htmldoc = '<div class="panel-body"><div class="data_title"><a href="';
                        htmldoc = htmldoc + '/detail_echo_village?village_name=' + datajson[i].village_name +"&address=" + datajson[i].address 
                                          + "&program_hash=" + datajson[i].program_hash +       "&village_code=" + datajson[i].village_code
                                          + "&x=" + datajson[i].x +               "&y=" + datajson[i].y + '">' + datajson[i].village_name + '</a>';
                                          
                        htmldoc = htmldoc + '<span>조회수 : 100</span></div><div class="data_meta"><span>기관 : <font style="font-family:sans-serif,Courier;">'; 
                        htmldoc = htmldoc + datajson[i].village_name + '</font></span><span>장소 :';
                        htmldoc = htmldoc + datajson[i].address + '</span><span>연락처';
                        htmldoc = htmldoc + '없음';
                        htmldoc = htmldoc + '</span>'+ '<div class="data_content"><span>산촌 생태 마을 숙박 및 축제를 경험 할 수 있습니다.</span></div></div>';
                        
                        if(count==1){
                             $("#"+page_id).html(htmldoc);                 
                        }else{
                             $("#"+page_id).append(htmldoc);
                        }
                        
                        
                        htmlresult += htmldoc;
                    }
                    break;
                default:
                break;
            
            }
            
           
            
}



$(function () {
    
        //날짜 스크립트 부분
        
        $('#sandbox-container .input-group.date').datepicker({
            startDate: "today",
            format: 'yyyy/mm/dd',
            language: "kr",
            orientation: "bottom left",
            autoclose: true,
            todayHighlight: true
         
            
            
        });
    
        $('#se_input').click(function() {
            var htmlString = $("#deatail_v").clone().html();
            $( "#original_serach_input" ).html(htmlString);
        });
        
        
    
    
});

