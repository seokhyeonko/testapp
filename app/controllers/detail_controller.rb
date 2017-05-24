require ('open-uri')        # 웹 페이지 open 에 필요.
require ('json') 
require "net/https"
require "uri"


class DetailController < ApplicationController

    layout "Detail" # layout 전체 부분 세팅 "Main"은 내가 임시로? 이름 정하는건가요?
    # 만든 거지ㅋㅋㅋ 원래 이렇게 만들면 안되는데 css나 js가 보통 홈페이지? 같은데서 디자인이 일정하거든
    # 근데 우리가 만들때 여러가지 불편할수도 있어서 따로 나눈거야
    # 각 필요한 css나 js파일 넣으라고 보통 head에 포함을 시키거든 이게 그림으로 하면 쉬운데
    def detail_program(name)

        puts '사진만들기!!'
        ###사진 출력한다.
               # JSON을 Hash로 변환하는데 필요.
       
        url = 'https://apis.daum.net/search/image?apikey=e39c413113cbc67c3c832186c1480624&q='
        url += name
        url += '&output=json&result=3'
        
        count = 0
        #'https://apis.daum.net/search/image?apikey=e39c413113cbc67c3c832186c1480624&q=다음카카오&output=json'
        while count<3
        
        puts '들어옴?'
        url = url.force_encoding('binary')
        url=WEBrick::HTTPUtils.escape(url)
        
        image = JSON.parse(open(url).read)
        #puts image
        
        puts 'main 픽 찍어야함'
        @main_pic = image["channel"]["item"][count]["image"]
        puts @main_pic
        
 
        res = Net::HTTP.get_response(URI.parse(@main_pic))
        
        puts res.code
        if res.code.to_i <400
            count=4
        else
           count+=1 
        end
        
        end
        
        
    end
  
    def like_count
        
        pro_institutes = ProEduction.where(pro_name:"숲 해설 프로그램")
        
        pro_institutes.each do|x|
            @like_cnt = x.like 
            @like_cnt += 1 # 증가
            x.like = @like_cnt
            x.save()
        end
        
        
        
     end 

     
     
     def explanation
        
        ### 값을 넘기는것
                                     
        @exp_facility = params[:facility] #시설
        @exp_facility_name = params[:facility_name] #시설이름
        @exp_address = params[:address] # 주소
        @exp_join_method = params[:join_method]#참여 방법
        @exp_period = params[:management_period] #활동기간
        @exp_tel = params[:tel] #전화번호
      
        for i in 0..@exp_period.length
               if @exp_period[i] == '1'
                   @exp_peroid_begin = i
                   break;
               else 
               end
            end
            
            
        for i in 0..@exp_period.length
               if @exp_period[i] == '1'
                   @exp_peroid_finish = i
               else 
               end
            end    
        @address = @exp_address
        @keyword = @exp_facility_name
        
        
        puts '사진 호출전'
        detail_program(@exp_facility)
        
        likedata = Like.find_by_pro_name(@exp_facility_name)
        @like = likedata.like
        @view_count = likedata.view_count+1
        
        likedata.view_count = @view_count
        likedata.save
        
         
     end

    def echo_village
       
        @echo_facility_name = params[:village_name] #시설이름
        @echo_address = params[:address] # 주소
        
        @echo_period = params[:program_hash] #활동기간
        puts @echo_address
        
        for i in 0..@echo_period.length
               if @echo_period[i.to_s] != '없음'
                   @echo_peroid_have = i
                   
               else 
               end
            end
      
      

        for i in 0..@echo_period.length
               if @echo_period[i.to_s] != '1'
                   @echo_peroid_finish = i
               else 
               end
            end    
        
        @address = @echo_address
        @keyword = @echo_facility_name
        
        likedata = Like.find_by_pro_name(@echo_facility_name)
        @like = likedata.like
        @view_count = likedata.view_count+1
        
        likedata.view_count = @view_count
        likedata.save
        
        
        detail_program(@echo_facility_name)

    end 
    
    def prenatal
   
    
        @pre_title = params[:title] #시설이름
        @pre_location = params[:location] # 주소
        @pre_content = params[:content] # 내용
        @pre_is_apply = params[:is_apply] # 신청가능 여부
        @pre_education_time = params[:education_time] # 활동시간
        @pre_entry_fee = params[:entry_fee] # 주소
        
        @pre_education_time_string = params[:education_time_string] #활동기간
        @pre_year = params[:year]
        @pre_month = params[:month]
        @pre_day = params[:day]
        @pre_link = params[:link]
        
        @address = @pre_title
        @keyword = @pre_location
        
       
        
        likedata = Like.find_by_pro_name(@pre_location)
        @like = likedata.like
        @view_count = likedata.view_count+1
        
        likedata.view_count = @view_count
        likedata.save
        
        detail_program(@pre_location)

    
    end
    
    def lodge
       
        @lodge_name = params[:name] #시설이름
#        @lodge_state = params[:state] # 주소
#        @lodge_lodage_classification = params[:lodage_classification] # 내용
        @lodge_size = params[:size] # 신청가능 여부
        @lodge_available_people = params[:available_people] # 활동시간
        @lodge_enterence_fee = params[:enterence_fee] # 주소

        @lodge_is_stay = params[:is_stay] 
        @lodge_major_facilities = params[:major_facilities] 
        @lodge_address = params[:address] 
#        @lodge_management = params[:management] 
        @lodge_tel = params[:tel] 
        @lodge_homepage_add = params[:homepage_add]
        @lodge_latitude = params[:longitude] 
        @lodeg_data_standard_date = params[:data_standard_date] 
        puts @lodge_homepage_add
        
        @address = @lodge_address
        @keyword = @lodge_name
                 
        likedata = Like.find_by_pro_name(@lodge_name)
        @like = likedata.like
        @view_count = likedata.view_count+1
        
        likedata.view_count = @view_count
        likedata.save         
                 
        detail_program(@lodge_name)
    
    end
    
    def arboretum
       
        @arb_name = params[:name] # 신청가능 여부
        @arb_address = params[:address] # 활동시간
        @arb_size = params[:size] # 주소
        @arb_plants_numbers = params[:plants_numbers] # 주소
        @arb_start_date = params[:start_date] # 주소
        @arb_tel = params[:tel] # 주소
        @arb_content = params[:content] # 주소
        arboretum_ob = MakeArboretumData.create
        @arb_related_link = params[:related_link] # 주소
        data = arboretum_ob.getContentAndHomeaddress(@arb_related_link)
        @arb_related_link = 'http://www.forest.go.kr'.concat(@arb_related_link)
        @content = data[0]
        @arb_homepage_addr = data[1] # 주소
        
        puts @arb_related_link
        puts @arb_homepage_addr
        
        @address = @arb_address
        @keyword = @arb_name
        
        likedata = Like.find_by_pro_name(@arb_name)
        @like = likedata.like
        @view_count = likedata.view_count+1
        
        likedata.view_count = @view_count
        likedata.save  
        
        detail_program(@arb_name)

        
    end
    
    def program
        
        @program_name = params[:program_name]
        @facility = params[:facility]
        @address = params[:address]
        @ptype = params[:ptype]
        @limit_people = params[:limit_people]
        @period = params[:period]
        @target = params[:target]
        @content = params[:content]
        @like = params[:like]
        @view_count = params[:count_view]
        @tel = params[:tel]
        
      
        @keyword = @program_name
        
        
        detail_program(@program_name)
        
        current_program = Proeducation.find_by_pro_name(@program_name)
        @view_count = current_program.count_view+1
        current_program.count_view = current_program.count_view+1
        current_program.save
        
        @like = current_program.like
    end
    
    
    
    
    
    def likeup
        puts "좋업"
       pro_name = params[:p_name]
       data = Like.find_by_pro_name(pro_name)
       pre_value = data.like
       data.like = pre_value+1
       data.save
    end
    
    def likedown
        pro_name = params[:p_name]
       data = Like.find_by_pro_name(pro_name)
       pre_value = data.like
       data.like = pre_value-1
       data.save
    end
    
    def program_likeup
         puts "좋업"
        pro_name = params[:p_name]
        puts pro_name
        pro = Proeducation.find_by_pro_name(pro_name)
        pro.like = pro.like+1
        pro.save
    end
    
    def program_likedown
        pro_name = params[:p_name]
        pro = Proeducation.find_by_pro_name(pro_name)
        pro.like = pro.like-1
        pro.save
        
    end
    
    def apply_program
        name = params[:name]
        phone = params[:phone]
        email = params[:email]
        number = params[:number]
        program_name = params[:p_name]
        date = params[:date]
        
        booker = Booker.new
        booker.name = name
        booker.tel = phone
        booker.email = email
        booker.date = date
        booker.pro_name = program_name
        booker.count = number.to_i
        booker.save
        
        puts "예약자 저장 완료"
    
    end
    


    
end
