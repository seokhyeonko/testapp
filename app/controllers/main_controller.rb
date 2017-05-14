require "#{Dir.pwd}/app/models/MountainEducationData.rb"
require "#{Dir.pwd}/app/models/Forestlodge.rb"
require "#{Dir.pwd}/app/models/Arboretum.rb"
require "#{Dir.pwd}/app/models/Prenataleducation.rb"
require "#{Dir.pwd}/app/models/EcoVilegeProgram.rb"
require "#{Dir.pwd}/app/models/MountainExplain.rb"
require 'json'


module TARGET
    TEENAGER = 'teenager'
    BABY = 'baby'
    PRENATAL = 'prenatal'
    ELEMENTRY = 'elementry'
    NORMAL = 'normal'
    
end

module CATEGORY
    FOREST_LODGE = 'forestlodge'
    ARBORETUM = 'arboretum'
    ECOVILAGE = 'ecovilage'
    MOUNTAIN_PROGRAM = 'mountainpro'
    PRENATALEDU = 'prenataledu'
    MOUNTAIN_EXPALIN = 'mountain_explain'
end


class MainController < ApplicationController
    layout "Main"
   
    def search_view
        @recommend_program = Array.new
        
        data_withoutMountainPro = Like.all.order("like DESC")
        
        count = 0
        
        data_withoutMountainPro.each do|data|
            if count===3
                break
            end
            count+=1
            
            @recommend_program.push(data)
        end
        
        
        
    
    end
    
    def search_result_view
    
        targetarr = params[:target]
        categoryarr = params[:category]
        date = params[:date]
        query = params[:query]
        
        target_str = ""
        category_str = ""
        #검색어 질의 처리 생각해봐야함 우선 빈칸으로 나누고 매일 앞의 글자로 위치 검색하게 만듬
        location_str = query.split(' ')
        
        if location_str[0].length >=2
           query = ""
           co = 0
           location_str[0].each_char{|c| 
               if co===2 
                   break
               end
               query.concat(c)
               co+=1
           }
           location_str[0] = query
        end
        
   
        
        year = 2017
        month = 5
        day = 1
        
        
        puts targetarr
        puts categoryarr
        puts date
        
        
        is_target = true
        is_category = true
        is_date = true
        is_query = true
        
        # Parameters: {"target"=>["baby_chbox", "prenatal", "elementry", "teenager", "normal"]
        if targetarr==nil
            is_target = false
        else
            targetarr.each do|target|
                if target.include?("baby")
                    target_str.concat('유아,')
                elsif target.include?("prenatal")
                    target_str.concat('임산부,')
                elsif target.include?("elementry")
                    target_str.concat('초등학생,')
                elsif target.include?("teenager")
                    target_str.concat('중.고등학생,')
                else
                    target_str.concat('일반,')
                end    
            end
        end
        
        targetarr_temp = target_str.split(',')
        
        #{"category"=>["forestlodge", "arboretum", "ecovilage", "mountainpro", "prenataledu", "mountain_explain"]
        if categoryarr ==nil
            is_category = false
        else
            categoryarr.each do |cate|
                if cate.include?("forestlodge")
                    category_str.concat('휴양림,')
                elsif cate.include?("arboretum")
                    category_str.concat('식목원,')
                elsif cate.include?("ecovilage")
                    category_str.concat('산촌마을,')
                elsif cate.include?("mountainpro")
                    category_str.concat('산림교육,')
                elsif cate.include?("prenataledu")
                    category_str.concat('숲태교,')    
                else
                    category_str.concat('숲해설,')
                end 
            end
        end
        
        if date.eql?("")
            is_date = false
        else
            temp = date.split('/')
            year = temp[0].to_i
            month = temp[1].to_i
            day = temp[2].to_i
        end
        
        if query.eql?("")
            is_query = false
        end
        
        tag_arr = Array.new
        
        
        
        @arboretum_arr = nil
        @prenatal_arr = nil
        @forestlodge_arr = nil
        @ecovilage_arr = nil
        @mountain_explain_arr = nil
        @mountain_program_arr = nil
        
        #산림교육프로그램데이터 아직 안만듬 만들어야함
        
        mountain_explain_ob = MakeMountainExpalinData.create
        arboretum_ob = MakeArboretumData.create
        prenatal_ob = MakePrenataleducationData.create
        forestlodge_ob = MakeForestLodageData.create
        ecovilage_ob = MakeEcoVillageData.create
        #@mountain_program_arr -> 디비 조회 추가 예정
        
        
        #기관,위치는 기본 검색
        # T T T -> 2^3 = 8
        # 각각의 경우에 대해서 처리
        # 휴양림은 위치로 검색
        # 숲 체험은 대상, 날짜 , 위치 판별하여 검색
        # 산촌 체험은 날짜만 판별하여 검색
        # 식목원은 위치만 검색
        # 산림교육 대상, 위치, 날짜 
        # 숲 태교 날짜, 위치 검색
        
     
        #모든 상세검색에 대한 옵션이 정해졌을 경우
        #위치만 들어왔다고 가정하고 검색
        if is_query
            if is_target && is_category && is_date
                
                if category_str.include?('휴양림')
                    @forestlodge_arr = forestlodge_ob.getForestLodageData_Location(location_str[0])
                end
                
      
                if category_str.include?('식목원')
                    @arboretum_arr = arboretum_ob.getArboretum_withAdress(location_str[0])
                end
                
                if category_str.include?('산촌마을')
                    @ecovilage_arr = ecovilage_ob.getEcoVillageData_with_monthAndLocation(month,location_str[0])
                end
                
                #디비에서 조회해야함
                if category_str.include?('산림교육')
                    @mountain_program_arr = Array.new
                    mpro_data = Proeducation.all

                    mpro_data.each do|data|
                        
                        if data.address.to_s.include?(location_str[0])
                                #3월~5월,11월~12월 정확히 입력되어져야함
                                mp = [0,0,0,0,0,0,0,0,0,0,0,0,0]   
                               
                                period_str = (data.period).to_s.split(',')
                                period_str.each do|period|
                                    mp = makeMountainPro_periodInfo(period,mp)
                                end
                                
                                if mp[month]===1
                                    @mountain_program_arr.push(data)
                                end
                        end
                    end
      
                    
                end
                
                if category_str.include?('숲태교')
                    @prenatal_arr = prenatal_ob.getPrenatalEducationWith_MonthAndLocation(month,location_str[0])
                end
                
                if category_str.include?('숲해설')
                    @mountain_explain_arr = mountain_explain_ob.getMountainExpalinData_withAllCheck(location_str[0],month,target_str)
                end
            
            
            
            #대상과 카테고리만
            elsif is_target && is_category && is_date ==false
                if category_str.include?('휴양림')
                    @forestlodge_arr = forestlodge_ob.getForestLodageData_Location(location_str[0])
                end

                if category_str.include?('식목원')
                    @arboretum_arr = arboretum_ob.getArboretum_withAdress(location_str[0])
                end
                
                if category_str.include?('산촌마을')
                    @ecovilage_arr = ecovilage_ob.getEcoVillageData_with_location(location_str[0])
                end
                
                #디비에서 조회해야함 노인 및 다른 데이터도 있어서 우선 다보여주게 만듬
                if category_str.include?('산림교육')
                    @mountain_program_arr = Proeducation.all
                    #mpro_data = Proeducation.all
=begin
                    mpro_data.each do|data|
                        temp_target = data.target.to_s
                        if target_str.include?(temp_target)
                        end
                       
                    end
=end                     
                end
                
                if category_str.include?('숲태교')
                    @prenatal_arr = prenatal_ob.getPrenatalEducationWith_location(location_str[0])
                end
                
                if category_str.include?('숲해설')
                    @mountain_explain_arr = mountain_explain_ob.getMountainExpalinData_withLocationAndTarget(location_str[0],target_str)
                end
            #대상만
            elsif is_target && is_category ==false && is_date ==false
                targetarr_temp.each do|target_data|
                    case target_data
                    when '임산부'
                         @prenatal_arr = prenatal_ob.getPrenatalEducationWith_location(location_str[0])
                    else
                        if @mountain_explain_arr!=nil
                             @mountain_explain_arr.concat(mountain_explain_ob.getMountainExpalinData_withTarget(target_str))     
                        else
                             @mountain_explain_arr = mountain_explain_ob.getMountainExpalinData_withTarget(target_str)
                        end
                       @mountain_program_arr = Proeducation.all
                        #산림교육 데이터 넣어야함
                    end
                        
                end
            #날짜와 대상만
            elsif is_target && is_category ==false && is_date
    
                targetarr_temp.each do|target_data|
                    case target_data
                    when '임산부'
                         @prenatal_arr = prenatal_ob.getPrenatalEducationWith_MonthAndLocation(month,location_str[0])
                    else
                        if @mountain_explain_arr!=nil
                             @mountain_explain_arr.concat(mountain_explain_ob.getMountainExpalinData_withTarget(target_str))     
                        else
                             @mountain_explain_arr = mountain_explain_ob.getMountainExpalinData_withTarget(target_str)
                        end
                        
                        @mountain_program_arr = Array.new
                        mpro_data = Proeducation.all
    
                        mpro_data.each do|data|
                            
                            if data.address.to_s.include?(location_str[0])
                                    #3월~5월,11월~12월 정확히 입력되어져야함
                                    mp = [0,0,0,0,0,0,0,0,0,0,0,0,0]   
                                   
                                    period_str = (data.period).to_s.split(',')
                                    period_str.each do|period|
                                        mp = makeMountainPro_periodInfo(period,mp)
                                    end
                                    
                                    if mp[month]===1
                                        @mountain_program_arr.push(data)
                                    end
                            end
                        end
                    end
                        
                end
            #분류와 날짜만
            elsif is_target==false && is_category && is_date
                if category_str.include?('휴양림')
                    @forestlodge_arr = forestlodge_ob.getForestLodageData_Location(location_str[0])
                end
                
      
                if category_str.include?('식목원')
                    @arboretum_arr = arboretum_ob.getArboretum_withAdress(location_str[0])
                end
                
                if category_str.include?('산촌마을')
                    @ecovilage_arr = ecovilage_ob.getEcoVillageData_with_monthAndLocation(month,location_str[0])
                end
                
                #디비에서 조회해야함
                if category_str.include?('산림교육')
                    @mountain_program_arr = Array.new
                    mpro_data = Proeducation.all

                    mpro_data.each do|data|
                        
                        if data.address.to_s.include?(location_str[0])
                                #3월~5월,11월~12월 정확히 입력되어져야함
                                mp = [0,0,0,0,0,0,0,0,0,0,0,0,0]   
                               
                                period_str = (data.period).to_s.split(',')
                                period_str.each do|period|
                                    mp = makeMountainPro_periodInfo(period,mp)
                                end
                                
                                if mp[month]===1
                                    @mountain_program_arr.push(data)
                                end
                        end
                    end
                end
                
                if category_str.include?('숲태교')
                    @prenatal_arr = prenatal_ob.getPrenatalEducationWith_MonthAndLocation(month,location_str[0])
                end
                
                if category_str.include?('숲해설')
                    @mountain_explain_arr = mountain_explain_ob.getMountainExpalinData_withLocationAndMonth(location_str[0],month)
                end
                
            #카테고리만
            elsif is_target ==false && is_category && is_date ==false
                if category_str.include?('휴양림')
                    @forestlodge_arr = forestlodge_ob.getForestLodageData_Location(location_str[0])
                end
                
      
                if category_str.include?('식목원')
                    @arboretum_arr = arboretum_ob.getArboretum_withAdress(location_str[0])
                end
                
                if category_str.include?('산촌마을')
                    @ecovilage_arr = ecovilage_ob.getEcoVillageData_with_location(location_str[0])
                end
                
                #디비에서 조회해야함
                if category_str.include?('산림교육')
                    @mountain_program_arr = nil
                end

                if category_str.include?('숲태교')
                    @prenatal_arr = prenatal_ob.getPrenatalEducationWith_location(location_str[0])
                end
                
                if category_str.include?('숲해설')
                    @mountain_explain_arr = mountain_explain_ob.getMountainExpalinData_withLocation(location_str[0])
                end
                
                
            #날짜만
            elsif is_target ==false && is_category ==false && is_date
                @forestlodge_arr = forestlodge_ob.getForestLodageData_Location(location_str[0])
                @arboretum_arr = arboretum_ob.getArboretum_withAdress(location_str[0])
                @ecovilage_arr = ecovilage_ob.getEcoVillageData_with_monthAndLocation(month,location_str[0])
                #디비에서 조회해야함
                @mountain_program_arr = Array.new
                    mpro_data = Proeducation.all

                    mpro_data.each do|data|
                                mp = [0,0,0,0,0,0,0,0,0,0,0,0,0]   
                               
                                period_str = (data.period).to_s.split(',')
                                period_str.each do|period|
                                    mp = makeMountainPro_periodInfo(period,mp)
                                end
                                
                                if mp[month]===1
                                    @mountain_program_arr.push(data)
                                end
                    end
                
                
                
                
                
                @prenatal_arr = prenatal_ob.getPrenatalEducationWith_MonthAndLocation(month,location_str[0])
                @mountain_explain_arr = mountain_explain_ob.getMountainExpalinData_withLocationAndMonth(location_str[0],month)
            #그냥 검색! 모든 데이터 조회
            else
                
                @forestlodge_arr = forestlodge_ob.getForestLodageData_Location(location_str[0])
                @arboretum_arr = arboretum_ob.getArboretum_withAdress(location_str[0])
                @ecovilage_arr = ecovilage_ob.getEcoVillageData_with_location(location_str[0])
                #디비에서 조회해야함
                @mountain_program_arr = Proeducation.all
                @prenatal_arr = prenatal_ob.getPrenatalEducationWith_location(location_str[0])
                @mountain_explain_arr = mountain_explain_ob.getMountainExpalinData_withLocation(location_str[0])
            end
        end
        
        checkDatabase(@mountain_explain_arr, @forestlodge_arr,@arboretum_arr, @ecovilage_arr,@prenatal_arr)
        
        @arboretum_size = 0
        @prental_size = 0
        @forestlodge_size = 0
        @ecovilaage_size = 0
        @mountain_explain_size = 0
        @mountain_program_size = 0
        
        if @arboretum_arr !=nil
            @mountain_program_size = @mountain_program_arr.size()
        end
        
        if @prenatal_arr !=nil
            @prental_size = @prenatal_arr.size()
        end
        
        if @forestlodge_arr !=nil
            @forestlodge_size = @forestlodge_arr.size()
        end
        
        if @ecovilage_arr !=nil
            @ecovilaage_size = @ecovilage_arr.size()
        end
        
        if @mountain_program_arr !=nil
            @arboretum_size = @arboretum_arr.size()
        end
        
        if @mountain_explain_arr !=nil
            @mountain_explain_size = @mountain_explain_arr.size()
        end
       
        @mountain_explain_json = @mountain_explain_arr.to_json()
        @total_count = @arboretum_size + @prental_size +  @forestlodge_size + @ecovilaage_size + @arboretum_size + @mountain_explain_size + @mountain_program_size
     
        
     
        
    end
    
    def checkDatabase(mountain_explain,forestlodge,arboretum,eco_village,prenatal)
        
   
        if mountain_explain !=nil
            mountain_explain.each do|ex|
                db_data = Like.find_by_pro_name(ex.getFacilityName)
                
                if db_data==nil
                    data = Like.new
                    data.pro_name = ex.getFacilityName
                    data.like = 0
                    data.view_count = 0
                    data.save()
                end
            end
        end
        
        if forestlodge !=nil
            forestlodge.each do|ex|
                db_data = Like.find_by_pro_name(ex.getName)
                
                if db_data==nil
                    data = Like.new
                    data.pro_name = ex.getName
                    data.like = 0
                    data.view_count = 0
                    data.save()
                end
            end
        end
        
        if arboretum !=nil
            arboretum.each do|ex|
                db_data = Like.find_by_pro_name(ex.getName)
                
                if db_data==nil
                    data = Like.new
                    data.pro_name = ex.getName
                    data.like = 0
                    data.view_count = 0
                    data.save()
                end
            end
        end
        
        if eco_village !=nil
            eco_village.each do|ex|
                db_data = Like.find_by_pro_name(ex.getName)
                
                if db_data==nil
                    data = Like.new
                    data.pro_name = ex.getName
                    data.like = 0
                    data.view_count = 0
                    data.save()
                end
            end
        end
        
        #숲태교는 주소로 정보를 가져옴!
        if prenatal !=nil
            prenatal.each do|ex|
                db_data = Like.find_by_pro_name(ex.getLocation)
                
                if db_data==nil
                    data = Like.new
                    data.pro_name = ex.getLocation
                    data.like = 0
                    data.view_count = 0
                    data.save()
                end
            end
        end
        
        
        
        
    end
    
    def makeMountainPro_periodInfo(str,arr)
        temp = str.split('~')
        s_number = temp[0].slice!(0)
        e_number = temp[1].slice!(0)
        
        
        for i in s_number..enumber
            arr[i] = 1
        end
        
        return arr
    end
    
    
    
    def temp
      
        ob = MakeMountainExpalinData.create
 
        data = ob.getMountainExpalinData_withLocation("강원")
        

        if data!=nil 
            @data = data
        end 
    end
    
    

end





