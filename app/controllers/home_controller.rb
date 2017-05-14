
require "#{Dir.pwd}/app/models/MountainEducationData.rb"
require "#{Dir.pwd}/app/models/Forestlodge.rb"
require "#{Dir.pwd}/app/models/Arboretum.rb"
require "#{Dir.pwd}/app/models/Prenataleducation.rb"
require "#{Dir.pwd}/app/models/EcoVilegeProgram.rb"
require "#{Dir.pwd}/app/models/MountainExplain.rb"

require 'nokogiri' # 파싱 젬
require ('open-uri') # url 요청
require "addressable/uri" # 인코딩
require "json"
require "date"



class HomeController < ApplicationController
    
 
    def index
        #Time.now.strftime("%d/%m/%Y %H:%M").to_s
        
        #ob = MakeEcoVillageData.create
        #data = ob.getPrenatalEducationWith_month(5)
        #data = ob.getPrenatalEducationWith_location('경기')
        #@data = ob.getEcoVillageData_with_location('전라')
        
        
        #@data = @data[0].getName
        #@data = @data[2].getProgramMonth(5)
        ob = MakePrenataleducationData.create

        data = ob.getAllPrenatalEducation

    
        if data!=nil 
            @data = data
        end
        
    end
    
    
   
    
    def howTogetForestLodge #휴양림 정보 얻는 방법
        ob = MakeForestLodageData.create
 
        data = ob.getForestLodageData_Location("주소")
        data = ob.getForestLodageData_NameAndLocation("휴양림 이름","주소")
        data = ob.getForestLodageData_Name("휴양림 이름")
        data = ob.getAllForestLodageData  # 전체 데이터

        if data!=nil 
            @data = data[0].getAddress
        end
        
    end
    
    def howTogetArboretumDATA #식물원
        ob = MakeArboretumData.create
        data = ob.getAllArboretumData
        data = ob.getArboretum_withName("식목원 이름")
        data = ob.getArboretum_withAdress("식목원 주소")
        data = ob.getArboretum_withNameAndAddress("이름","주소")
        if data!=nil 
            @data = data[0].getAddress
        end
    end
    
    def howTogetPrenataleducationDATA #숲 태교 데이터
        ob = MakePrenataleducationData.create
        data = ob.getPrenatalEducationWith_month(month)
        data = ob.getPrenatalEducationWith_location(location)
        data = ob.getPrenatalEducationWith_MonthAndLocation(month,location)
    
        if data!=nil 
            @data = data[0].getTitle
        end
    
    end
    
end


