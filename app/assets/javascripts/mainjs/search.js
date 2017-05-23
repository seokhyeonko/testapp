$(function() {
   
    
    
    $('#search_form').on('submit', function () {
        
        var temp = document.getElementById('query_bar').value;
    
        
        if(temp==''){
            bootbox.alert({
             message: "지역명 키워드를 입력해주세요!",
             backdrop: true
            });    
            return false;
        }
        
         
         
        
    });
  
  
  
  

});

