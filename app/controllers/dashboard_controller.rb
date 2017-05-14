module INSTITUTE
    ID = 'institute_id'
    PW = 'institute_pw'
    NAME = 'institute_name'
end





class DashboardController < ApplicationController

 
    layout 'dashboard_head'
    
    
    #아이디 비번 체크 아작스로 받은 후 성공을 리턴
    def storedata_session(id,institue_name)
       
       if session[:id] !=nil 
           return
       end
       session[:id] = id
       session[:institute_name] = institue_name
        
    end
    
    
    #가지고 있는 프로그램 리스트 뿌려주기 
    def intro_dashboard
        id = params[:username]
        pw = params[:password]
        
        if session[:id] ==nil
            user = Institute.find_by_institute_id(id)
        
            if user!=nil #아이디 존재
                if !user.institute_pw.eql?(pw)
                    flash[:notice] = "비번아이디 오류"
                    redirect_to :back
                end
            else
                flash[:notice] = "비번아이디 오류"
                redirect_to :back
            end
            
            storedata_session(id,user.institute_name)
        end
        
        @programlist = Proeducation.find_by_pro_institute(session[:institute_name])
        @count = Proeducation.where(pro_institute: session[:institute_name]).count
        
        puts @count
        
        
        
        
        
           
         
    end
    
    
    
    
   #예약자들 확인
   def booker_check
        data = Proeducation.all 
        
        @d = Array.new
        data.each do|d|
            if d.pro_institute.eql?(session[:institute_name])
                @d.push(d.pro_name)
            
            end
        end


    end 
    
    
    
    
    #프로그램마다 disable 해주기
    def check_day_program
        data = Proeducation.all 
        
        @d = Array.new
        data.each do|d|
            if d.pro_institute.eql?(session[:institute_name])
                @d.push(d.pro_name)
            
            end
        end
        
    end
    
    
    
    def dashboard4
    end
    
    
    
    def dashboard5
        @check1 =params[:check1]
        @check2 =params[:check2]
        @check3 =params[:check3]
        @check4 =params[:check4]
        @check5 =params[:check5]
        @check6 =params[:check6]
        @check7 =params[:check7]
        @check8 =params[:check8]
        @check9 =params[:check9]
        @check10 =params[:check10]
        @check11 =params[:check11]
        @check12 =params[:check12]
        @check13 =params[:check13]
        @check14 =params[:check14]
        @check15 =params[:check15]
        @check16 =params[:check16]
        @check17 =params[:check17]
        @check18 =params[:check18]
        @check19 =params[:check19]
        @check20 =params[:check20]
        @check21 =params[:check21]
        @check22 =params[:check22]
        @check23 =params[:check23]
        @check24 =params[:check24]
        @check25 =params[:check25]
        @check26 =params[:check26]
        @check27 =params[:check27]
        @check28 =params[:check28]
        @check29 =params[:check29]
        @check30 =params[:check30]
        @check31 =params[:check31]
        

        if @check1=='1'
        @check1='disable'
        end
        if @check2=='1'
        @check2='disable'
        end
        if @check3=='1'
        @check3='disable'
        end
        if @check4=='1'
        @check4='disable'
        end
        if @check5=='1'
        @check5='disable'
        end
        if @check6=='1'
        @check6='disable'
        end
        if @check7=='1'
        @check7='disable'
        end
        if @check8=='1'
        @check8='disable'
        end
        if @check9=='1'
        @check9='disable'
        end
        if @check10=='1'
        @check10='disable'
        end
        if @check11=='1'
        @check11='disable'
        end
        if @check12=='1'
        @check12='disable'
        end
        if @check13=='1'
        @check13='disable'
        end
        if @check14=='1'
        @check14='disable'
        end
        if @check15=='1'
        @check15='disable'
        end
        if @check16=='1'
        @check16='disable'
        end
        if @check17=='1'
        @check17='disable'
        end
        if @check18=='1'
        @check18='disable'
        end
        if @check19=='1'
        @check19='disable'
        end
        if @check20=='1'
        @check20='disable'
        end
        if @check21=='1'
        @check21='disable'
        end
        if @check22=='1'
        @check22='disable'
        end
        if @check23=='1'
        @check23='disable'
        end
        if @check24=='1'
        @check24='disable'
        end
        if @check25=='1'
        @check25='disable'
        end
        if @check26=='1'
        @check26='disable'
        end
        if @check27=='1'
        @check27='disable'
        end
        if @check28=='1'
        @check28='disable'
        end
        if @check29=='1'
        @check29='disable'
        end
        if @check30=='1'
        @check30='disable'
        end
        if @check31=='1'
        @check31='disable'
        end
        
    end
    
    
    def dashboard_test
        data = Proeducation.all 
        @d = Array.new
        data.each do|d|
            if d.pro_institute.eql?($look_institute_name)
                @d.push(d.pro_name)
            
            end
        end
        
    end


    def datatest
        data6=Institute.find_by_institute_id(params[:username])
        data = Proeducation.all
        
        @d = Array.new
        data.each do|d|
            if d.pro_institute.eql?(data6.institute_name)
                @d.push(d.pro_name)
            
            end
        end
    
    
    end
    
    def manjung
        $id = params[:username]
            $pw = params[:password]
            
            user = Institute.find_by_institute_id($id)
            
            islogin = true
           
            
            if user!=nil
                if !user.institute_pw.eql?($pw)
                    islogin = false
                end
            else
               islogin = false 
            end
            
         if !islogin
                redirect_to :back
          end
     
#--------------------------------로그인된 desh board에서 기관명 띄워주기-------------------------           
            view_data1=Institute.where(institute_id: params[:username])
            view_data1.each do|program|
              $look_institute_name=program.institute_name
              @test=4
              dashboard2
          end


#----------------------------------db실험(0) 행과 열,교차 특정값 출력--------------------------------------
        #ptype이 "숲해설" 인 행(row) 중에 pro_name 열과 교차 하는 데이터값을 출력
        data2=Proeducation.where(ptype:"숲해설")
         data2.each do|x|
                @sample_name2=x.pro_name
            end

        
#-----------------------------------db실험(1) 외래키 이용----------------------------------------------
        
        #Institute(기관)의 id를 통해 institute_name(기관명)=>외래키 를 거쳐 
        #Proeducation(프로그램)의 타겟 컬럼을 따옴 
        
         data1=Institute.where(institute_id:"4")
         data1.each do|x|
                @sample_name1=x.institute_name
            end
            
         data3=Proeducation.where(pro_name:@sample_name1)
         data3.each do|x|
                @sample_name3=x.target
            end
#------------------------------------db실험(2) 외래키 이용(2)------------------------------------------            
         #Institute(기관)의 id를 통해 institute_name(기관명)=>외래키 를 거쳐 
        #IsProgram(예약금지 날짜)의 date 컬럼을 따옴 
           
         data4=Institute.where(institute_id:"4")
         data4.each do|x|
                @sample_name4=x.institute_name
            end
            
         data5=IsProgram.where(pro_name: @sample_name4)
         data5.each do|x|
                @sample_name5=x.date
            end

#--------기능: 이미 따온 @look_institute_name(기관명) 을 통해 Proeducation테이블에서 pro_name 가져오기------------------------------------------            
         
         
         
     data6=Institute.find_by_institute_id(params[:username]) #각 id에 해당하는 row 값이 data6에 저장 
        data = Proeducation.all 
        
        @d = Array.new
        data.each do|d|
            if d.pro_institute.eql?($look_institute_name)
                @d.push(d.pro_name)
            
            end
        end
        
          

#----------------------------db기능(프로그램갯수만큼만 첫페이지에서 소개하기)-------------------------------------

        


#--------------------------------------------------------------------------------
=begin


#------------------------------------------------------------------------------------------------
        #<Proeducation>더미 db(1)
         program1=Proeducation.new    
         program1.pro_name="숲 해설 프로그램"
         program1.pro_institute="경기도잣향기푸른숲"
         program1.address="경기도 가평군 상면 축령로 289-146"
         program1.ptype="숲해설"
         program1.limit_people="20"
         program1.period="3월~4월"
         program1.target="전연령"
         program1.content="숲해설"
         program1.like=10
         program1.count_view=30
         program1.save()
        #<Proeducation>더미 db(2)
         program2=Proeducation.new    
         program2.pro_name="야호!숲이랑 놀자"
         program2.pro_institute="서울시 대공원"
         program2.address="서울시 역삼동 테크노벨리 하늘정원"
         program2.ptype="아동현장체험"
         program2.limit_people="200"
         program2.period="3월~8월"
         program2.target="10세~20세"
         program2.content="아동놀이"
         program2.like=100
         program2.count_view=200
         program2.save()
        #<Proeducation>더미 db(3)
         program4=Proeducation.new    
         program4.pro_name="야야! 신나는 유격훈련!"
         program4.pro_institute="육군 제 9보병사단"
         program4.address="북한산 어딘가"
         program4.ptype="훈련"
         program4.limit_people="1000"
         program4.period="12월~1월"
         program4.target="군인"
         program4.content="훈련"
         program4.like=0
         program4.count_view=1000
         program4.save()
         #<Proeducation>더미 db(3)
         program4=Proeducation.new    
         program4.pro_name="병장들아! 의무대가자"
         program4.pro_institute="육군 제 9보병사단"
         program4.address="북한산 어딘가"
         program4.ptype="훈련"
         program4.limit_people="1000"
         program4.period="12월~1월"
         program4.target="군인"
         program4.content="훈련"
         program4.like=0
         program4.count_view=1000
         program4.save()
#-------------------------------------------------------------------------------------------------        
         #<Institute>더미 db(1)
         institute1=Institute.new
         institute1.institute_id="1"
         institute1.institute_pw="1"
         institute1.institute_name="경기도잣향기푸른숲"
         institute1.save()
         #<Institute>더미 db(2)
         institute2=Institute.new
         institute2.institute_id="2"
         institute2.institute_pw="2"
         institute2.institute_name="서울시 대공원"
         institute2.save()
         #<Institute>더미 db(3)
         institute4=Institute.new
         institute4.institute_id="3"
         institute4.institute_pw="3"
         institute4.institute_name="육군 제 9보병사단"
         institute4.save()
#-------------------------------------------------------------------------------------------------
        #<IsProgram>더미 db(1)
         disable1=IsProgram.new
         disable1.pro_name="숲 해설 프로그램"
         disable1.date="0522"  #5월 22일
         disable1.save()
         #<IsProgram>더미 db(2)
         disable2=IsProgram.new
         disable2.pro_name="숲 해설 프로그램"
         disable2.date="0524"  
         disable2.save()
         #<IsProgram>더미 db(3)
         disable3=IsProgram.new
         disable3.pro_name="야호!숲이랑 놀자"
         disable3.date="0512"  
         disable3.save()
         #<IsProgram>더미 db(4)
         disable4=IsProgram.new
         disable4.pro_name="야호!숲이랑 놀자"
         disable4.date="0502"  
         disable4.save()
         #<IsProgram>더미 db(7)
         disable7=IsProgram.new
         disable7.pro_name="야야! 신나는 유격훈련!"
         disable7.date="0522"  
         disable7.save()

=end
    
    
    
    
    end
    
    def tempdatastore
        #------------------------------------------------------------------------------------------------
        #<Proeducation>더미 db(1)
         program1=Proeducation.new    
         program1.pro_name="숲 해설 프로그램"
         program1.pro_institute="경기도잣향기푸른숲"
         program1.address="경기도 가평군 상면 축령로 289-146"
         program1.ptype="숲해설"
         program1.limit_people="20"
         program1.period="3월~4월"
         program1.target="전연령"
         program1.content="숲해설"
         program1.tel = "1234-1234-1234"
         program1.like=10
         program1.count_view=30
         program1.save()
        #<Proeducation>더미 db(2)
         program2=Proeducation.new    
         program2.pro_name="야호!숲이랑 놀자"
         program2.pro_institute="서울시 대공원"
         program2.address="서울시 역삼동 테크노벨리 하늘정원"
         program2.ptype="아동현장체험"
         program2.limit_people="200"
         program2.period="3월~8월"
         program2.target="10세~20세"
         program2.content="아동놀이"
         program2.tel = "1234-1234-1234"
         program2.like=100
         program2.count_view=200
         program2.save()
        #<Proeducation>더미 db(3)
         program4=Proeducation.new    
         program4.pro_name="야야! 신나는 유격훈련!"
         program4.pro_institute="육군 제 9보병사단"
         program4.address="북한산 어딘가"
         program4.ptype="훈련"
         program4.limit_people="1000"
         program4.tel = "1234-1234-1234"
         program4.period="12월~1월"
         program4.target="군인"
         program4.content="훈련"
         program4.like=0
         program4.count_view=1000
         program4.save()
         #<Proeducation>더미 db(3)
         program4=Proeducation.new    
         program4.pro_name="병장들아! 의무대가자"
         program4.pro_institute="육군 제 9보병사단"
         program4.tel = "1234-1234-1234"
         program4.address="북한산 어딘가"
         program4.ptype="훈련"
         program4.limit_people="1000"
         program4.period="12월~1월"
         program4.target="군인"
         program4.content="훈련"
         program4.like=0
         program4.count_view=1000
         program4.save()
#-------------------------------------------------------------------------------------------------        
         #<Institute>더미 db(1)
         institute1=Institute.new
         institute1.institute_id="1"
         institute1.institute_pw="1"
         institute1.institute_name="경기도잣향기푸른숲"
         institute1.save()
         #<Institute>더미 db(2)
         institute2=Institute.new
         institute2.institute_id="2"
         institute2.institute_pw="2"
         institute2.institute_name="서울시 대공원"
         institute2.save()
         #<Institute>더미 db(3)
         institute4=Institute.new
         institute4.institute_id="3"
         institute4.institute_pw="3"
         institute4.institute_name="육군 제 9보병사단"
         institute4.save()
#-------------------------------------------------------------------------------------------------
        #<IsProgram>더미 db(1)
         disable1=IsProgram.new
         disable1.pro_name="숲 해설 프로그램"
         disable1.date="0522"  #5월 22일
         disable1.save()
         #<IsProgram>더미 db(2)
         disable2=IsProgram.new
         disable2.pro_name="숲 해설 프로그램"
         disable2.date="0524"  
         disable2.save()
         #<IsProgram>더미 db(3)
         disable3=IsProgram.new
         disable3.pro_name="야호!숲이랑 놀자"
         disable3.date="0512"  
         disable3.save()
         #<IsProgram>더미 db(4)
         disable4=IsProgram.new
         disable4.pro_name="야호!숲이랑 놀자"
         disable4.date="0502"  
         disable4.save()
         #<IsProgram>더미 db(7)
         disable7=IsProgram.new
         disable7.pro_name="야야! 신나는 유격훈련!"
         disable7.date="0522"  
         disable7.save()
#-----------------------------------Booker 더미 1 ----------------------------------
         booker1=Booker.new
         booker1.tel="김만중"
         booker1.email="skekf123@naver.com"  
         booker1.date="0522"
         booker1.pro_name="숲 해설 프로그램"
         booker1.count="2"
         booker1.save()
#-----------------------------------Booker 더미 2 ----------------------------------
         booker2=Booker.new
         booker2.tel="손지현"
         booker2.email="qkqhthswl@naver.com"  
         booker2.date="0525"
         booker2.pro_name="야호!숲이랑 놀자"
         booker2.count="2"
         booker2.save()
#-----------------------------------Booker 더미 3 ----------------------------------
         booker3=Booker.new
         booker3.tel="손지현"
         booker3.email="qkqhthswl@naver.com"  
         booker3.date="0525"
         booker3.pro_name="야호!숲이랑 놀자"
         booker3.count="2"
         booker3.save()
    
    
end
    


end
