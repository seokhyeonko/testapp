
$(function () {
    $("#btndialog").click(
    
    function action () {
        var name = document.getElementById('name_apply').value;
        var phone = document.getElementById('phone_apply').value;
        var email =document.getElementById('email_apply').value;
        var number = document.getElementById('num_apply').value;
        var p_name = $('#keyword').text();
        var date = document.getElementById('date_apply').value;
        
       
        
        
    bootbox.confirm({
    message: "신청하시겠습니까?",
    buttons: {
        confirm: {
            label: '네',
            className: 'btn-success'
        },
        cancel: {
            label: '아니요',
            className: 'btn-danger'
        }
    },
    callback: function (result) {
        
        if(result){
             //ajax
             $.ajax({
              type:"GET",
              url:"/apply_program",
              dataType:"json",
              data: {name: name,phone: phone, email: email,number: number,date: date,p_name: p_name}
              
            });
            $('#exampleModal').modal('hide'); 
            alert("예약 완료!");
        }else{
            
        }
    }
}).find('.modal-content').css({
    'font-weight' : 'bold',
    'font-size': '2em',
    'margin-top': function (){
        var w = $( window ).height();
        var b = $(".modal-dialog").height();
        // should not be (w-h)/2

        return b+"px";
    }
});

      }
    );
    
    
   
    

  
    
});


