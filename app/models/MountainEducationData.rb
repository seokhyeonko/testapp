=begin
    1번은 유아숲 체험인데 3번의 프로그램에도 유아를 대상으로하는 프로그램이 많음
    따라서 1번의 데이터와 3번의 데이터를 함께 고려해주어야함

    우리가 고려해야 할것 : 기관명, 위치, 날짜, 대상, 프로그램 이름
    
    하나만 검색해도 검색이 되어야함 (예를들어 사용자가 위에 고려해야할 데이터중 하나만 선택해도)
    그에따라 데이터를 찾아서 보여줘야함!
    
    
    1. 각각의 모든 경우의수에 대해 메소드를 제작함 -> 비효율적
       -> (기관명), (위치), (날짜), (대상), (프로그램 이름)
          5개에서 한개 뽑는경우수 : 5
          5개에서 두개 뽑는경우수 : 5c2 = 10
          5개에서 세개 뽑는경우수 : 5c3 = 10
          5개에서 네게 뽑는경우수 : 5c4 = 5
          5개 다뽑는경우수 = 1  result = 31개 메소드 출현
    2. 우선 하나의 메소드에서 받은 다음 값이 null이 아니라면 비교해 데이터를 제작
       -> 하나의 메소드를 만들어서 우선 데이터를 다받음 (없는ㄷ ㅔ이터값음 null)
       -> if null 이아니면 데이터 세팅
       ex) 유아를 대상으로 할경우 1번과 3번을 고려하고 가져온 데이터 조회 으...토나옴ㅋㅋㅋㅋ
       알고리즘이당 꺄햐ㅏ하하하핳 
       아니면 5개중 두가지를 선택하면 두가지에 대해서 데이터를 환산해서 보여줘야함
       
       
=end

module Target
    CHILD = 100
    NORMAL = 101
    PREGNANT = 102
end

module EduType
  MOUNTAIN_CHILD = 1 #유아 숲 체험원
  MOUNTAIN_EDUCTION_CENTER = 2 #산림교육 센터 현황
  MOUNTAIN_EDUCATION_PROGRAM = 3 #산림교육 프로그램 현황
  MOUNTAIN_EDUCATION_MANAGEMENT = 4 #휴양림 및 수목원에서 진행하는 프로그램 현황
  MOUNTAIN_EXPLAIN = 5 #숲해설
end


class MountaionEducation
    private
    @program_title = nil
    @location = nil
    @period = nil#크기가 2인 배열로 이루어짐
    @price = nil
    @content = nil
    @tel = nil
    @consume_time = nil
    @available_time = nil
    @management = nil
    @category = nil
    
    def initialize(program_title,location,tel,management,content)
        @program_title = program_title
        @location = location
        @tel = tel
        @management = management
        @content =content
    end
    
    public
    
    def setPeriod(date)
        @period = date
    end
    
    def setPrice(price)
        @price = price
    end
    
    def setCategory(cate)
        @category = cate
    end
    
    def setConsumeTime(consume_time)
        @consume_time = consume_time
    end
    
    def setAvailableTime(time)
        @available_time = time
    end
    
    def getProgramTitle
        return @program_title
    end
    
    def getLocation
        return @location
    end
    
    def getPeriod
        return @period
    end
    
    
    def getPrice
        return @price
    end
    
    def getContent
        return @content
    end
    
    def getTel
        return @tel
    end
    
    def getConsumeTime
        return @consume_time
    end
    
    def getAvailTime
        return @available_time
    end
    
    def getManagement
        return @management
    end
    
    def getCategory
        return @category
    end

end

class Mountain_ParsingFromXml
    private_class_method :new    
    @@object = nil
    
    def getData(eduType)
        ob = MountainEducationFromServer.create
        #요청할 url을 만들고
        url = ob.getRequestUrl_allInformation(eduType)
        #한글로 요청하면 안됨으로 ascii 인코딩을 해준다음
        uri = Addressable::URI.parse(url)
        #요청한다
        return Nokogiri::XML(open(uri.normalize).read)
    end
    
    
    public
    
     def getMoutainProgramInformation(management,locaiton,date,target,program_title)
        #먼저 타겟을 생각하고 진행
        #중복선택 불가능
        
        #우선순위 기관 -> 프로그램 -> 날짜 -> 위치 -> 타겟
        data = nil
        ob = MountainEducationFromServer.create
        
        if target===Target::CHILD # 1번 3번
              xml_doc = getData(EduType::MOUNTAIN_CHILD) # 1번 요청
              puts xml_doc
              
              
              
              #3번데이터는 pdf file 가져와야함...
              
        elsif target===TARGET::NORMAL # 2번 3번 4번
                
        else # 임산부 태교 프로그램 따로!
        
        end
#require "#{Dir.pwd}/app/models/FestivalData.rb"            
    
    end
    #기관명, 위치, 날짜, 대상, 프로그램 이름
  
    
    def Mountain_ParsingFromXml.create    
        @@object = new unless @@object   
        return @@object
    end
    
end


class MountainEducationFromServer

    private_class_method :new    
    @@object = nil

    def initialize
        @request_url = 'http://openapi.forest.go.kr/openapi/service/cultureInfoService/frstEduInfoOpenAPI?eduType='
        
        @service_key = '%2BIgKioevFKszYJ73Dwn5uBgCj34qbLWXes8BkKmandxqFyLUGzzTobqNA8dHlYeJnU3OAHp1bniMtPB1tqhlvA%3D%3D'
       
    end
    
    def setEduTypeToUrl(eduType)
        url = nil
        if eduType===EduType::MOUNTAIN_CHILD
            url = @request_url + EduType::MOUNTAIN_CHILD.to_s
        elsif eduType===EduType::MOUNTAIN_EDUCTION_CENTER 
            url = @request_url + EduType::MOUNTAIN_EDUCTION_CENTER .to_s 
        elsif eduType===EduType::MOUNTAIN_EDUCATION_PROGRAM
            url = @request_url + EduType::MOUNTAIN_EDUCATION_PROGRAM.to_s 
        else
            url = @request_url + EduType::MOUNTAIN_EDUCATION_MANAGEMENT.to_s
        end
         
        return url
    end
    
    def setTitleToUrl( url , title)
        result_url = url+'&searchTitl='+title
        return result_url
    end
    
    


    public
    def getServiceKey
        return @service_key;
    end
    
    def getchild_forestType
        return @child_forest_type_number;
    end
    
    def get_mountain_departmentType
        return @mountain_department;
    end
    
    def get_mountain_centerType
        return @mountain_center;
    end
    
    def get_mountain_education_informationType
        return @mountain_education_information;
    end
    
    def getRequestUrl_allInformation(eduType)
        result_url = setEduTypeToUrl(eduType)
        result_url = result_url.concat('&ServiceKey=' + @service_key)
        result_url = result_url.concat('&pageNo=1&startPage=1&numOfRows=300&pageSize=300')
        return result_url
    end
    
    def getRequestUrl_Title(eduType, title)
        result_url = setEduTypeToUrl(eduType)
        result_url = setTitleToUrl(result_url,title)
        result_url = result_url.concat('&ServiceKey=' + @service_key)
        return result_url
    end

    def MountainEducationFromServer.create    
        @@object = new unless @@object   
        return @@object
    end

end
























class MountainEducationFromServerOriginal

    private_class_method :new    
    @@object = nil

    def initialize
        @request_url = 'http://openapi.forest.go.kr/openapi/service/cultureInfoService/frstEduInfoOpenAPI?eduType='
        
        @service_key = '%2BIgKioevFKszYJ73Dwn5uBgCj34qbLWXes8BkKmandxqFyLUGzzTobqNA8dHlYeJnU3OAHp1bniMtPB1tqhlvA%3D%3D'
        
        @child_forest_type_number = 1
        @mountain_department = 2
        @mountain_center = 3
        @mountain_education_information = 4
        
    end
    
    def setEduTypeToUrl(eduType)
        url = nil
        if eduType===@child_forest_type_number
            url = @request_url + @child_forest_type_number.to_s
        elsif eduType===@mountain_department 
            url = @request_url + @mountain_department.to_s 
        elsif eduType===@mountain_center
            url = @request_url + @mountain_center.to_s 
        else
            url = @request_url + @mountain_education_information.to_s
        end
         
        return url
    end
    
    def setTitleToUrl( url , title)
        result_url = url+'&searchTitl='+title
        return result_url
    end
    
    
    
    
    

    public
    def getServiceKey
        return @service_key;
    end
    
    def getchild_forestType
        return @child_forest_type_number;
    end
    
    def get_mountain_departmentType
        return @mountain_department;
    end
    
    def get_mountain_centerType
        return @mountain_center;
    end
    
    def get_mountain_education_informationType
        return @mountain_education_information;
    end
    
    def getRequestUrl_withoutTitle(eduType)
        result_url = setEduTypeToUrl(eduType)
        result_url = result_url.concat('&ServiceKey=' + @service_key)
        return result_url
    end
    
    def getRequestUrl_Title(eduType, title)
        result_url = setEduTypeToUrl(eduType)
        result_url = setTitleToUrl(result_url,title)
        result_url = result_url.concat('&ServiceKey=' + @service_key)
        return result_url
    end

    def MountainEducationFromServerOriginal.create    
        @@object = new unless @@object   
        return @@object
    end

end