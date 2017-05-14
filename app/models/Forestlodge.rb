require 'spreadsheet'

module LODGE_DATA
  NAME = 0 #이름
  STATE = 1 #시,군
  CLASSIFICATION = 2 #국,사유림 구분
  SIZE = 3 #크기
  AVAILPEOPLE = 4 #가용인원
  ENTERENCE_FEE=5 #입장비
  IS_STAY=6 #숙박가능여부
  MAJOR_FACILITIE=7 # 주요시설
  ADDRESS=8 # 도로명 주소
  MANAGEMENT=9 # 관리 기관
  TEL=10 #전화번호
  HOMPAGE_ADDR=11 #홈페이지 주소
  LATITUDE=12 #위도
  LONGITUDE=13 #경도
  DATA_STANDARD_DATE=14 #기준일자
end



class ForestLodge
    private
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
    
    def initialize(name,state,lodage_classification,size,available_people,
        enterence_fee,is_stay,major_facilities,address,management,tel,homepage_add,latitude,longitude,data_standard_date)
        @name = name
        @state = state
        @lodage_classification = lodage_classification#크기가 2인 배열로 이루어짐
        @size = size
        @available_people = available_people
        @enterence_fee = enterence_fee
        @is_stay = is_stay
        @major_facilities = major_facilities
        @address = address #도로명 주소
        @management = management
        @tel = tel
        @homepage_add = homepage_add
        @latitude = latitude
        @longitude = longitude
        @data_standard_date = data_standard_date
    end
    
    public
    
    def getName
        return @name
    end
    
    def getState
        return @state    
    end
    
    def getLodage_classification
        return @lodage_classification   
    end
    
    def getSize
        return @size
    end
    
    def getAvailPeople
        return @available_people
    end
    
    def getEnterenceFee
        return @enterence_fee
    end
    
    def getIsStay
        if @is_stay.include?('야영장') || @is_stay.include?('Y') || @is_stay.include?('y')
            return true
        end
        return false
    end
    
    def getMajroFacilities
        return @major_facilities
    end
        
    def getAddress
        return @address
    end
    
    def getManagement
        return @management
    end
    
    def getTel
        return @tel
    end
    
    def getHompageAddr
        return @homepage_add
    end
    
    def getLatitude
        return @latitude
    end
    
    def getLongtitude
        return @longitude
    end
    
    def getDataStandardDate
        return @data_standard_date
    end
        
end

class MakeForestLodageData
    private_class_method :new    
    @@object = nil
    
    
    
    public 
   
    def getAllForestLodageData
        book = Spreadsheet.open((Dir.pwd).concat('/data/lodge/forestlodge.xls'))

        loadge_arr = Array.new
    
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            if index!=0
                loadge_arr.push(ForestLodge.new(row[LODGE_DATA::NAME],row[LODGE_DATA::STATE],row[LODGE_DATA::CLASSIFICATION],row[LODGE_DATA::SIZE],
                                                row[LODGE_DATA::AVAILPEOPLE],row[LODGE_DATA::ENTERENCE_FEE],row[LODGE_DATA::IS_STAY],row[LODGE_DATA::MAJOR_FACILITIE],
                                                row[LODGE_DATA::ADDRESS],row[LODGE_DATA::MANAGEMENT],row[LODGE_DATA::TEL],row[LODGE_DATA::HOMPAGE_ADDR],
                                                row[LODGE_DATA::LATITUDE],row[LODGE_DATA::LONGITUDE],row[LODGE_DATA::DATA_STANDARD_DATE]))
               
            end
        end
  
       if loadge_arr.size ===0
            return nil
        else
            return loadge_arr
        end
    end
    
    def getForestLodageData_Location(location)
         book = Spreadsheet.open((Dir.pwd).concat('/data/lodge/forestlodge.xls'))
        location = location.to_s
       
        
        loadge_arr = Array.new
    
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            if index!=0
                if(row[LODGE_DATA::ADDRESS].include?(location))
                loadge_arr.push(ForestLodge.new(row[LODGE_DATA::NAME],row[LODGE_DATA::STATE],row[LODGE_DATA::CLASSIFICATION],row[LODGE_DATA::SIZE],
                                                row[LODGE_DATA::AVAILPEOPLE],row[LODGE_DATA::ENTERENCE_FEE],row[LODGE_DATA::IS_STAY],row[LODGE_DATA::MAJOR_FACILITIE],
                                                row[LODGE_DATA::ADDRESS],row[LODGE_DATA::MANAGEMENT],row[LODGE_DATA::TEL],row[LODGE_DATA::HOMPAGE_ADDR],
                                                row[LODGE_DATA::LATITUDE],row[LODGE_DATA::LONGITUDE],row[LODGE_DATA::DATA_STANDARD_DATE]))
             
                end
            end
        end
  
        if loadge_arr.size ===0
            return nil
        else
            return loadge_arr
        end
    end
    
    def getForestLodageData_Name(name)
         book = Spreadsheet.open((Dir.pwd).concat('/data/lodge/forestlodge.xls'))

        
        loadge_arr = Array.new
    
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            if index!=0
                if(row[LODGE_DATA::NAME].include?(name))
                loadge_arr.push(ForestLodge.new(row[LODGE_DATA::NAME],row[LODGE_DATA::STATE],row[LODGE_DATA::CLASSIFICATION],row[LODGE_DATA::SIZE],
                                                row[LODGE_DATA::AVAILPEOPLE],row[LODGE_DATA::ENTERENCE_FEE],row[LODGE_DATA::IS_STAY],row[LODGE_DATA::MAJOR_FACILITIE],
                                                row[LODGE_DATA::ADDRESS],row[LODGE_DATA::MANAGEMENT],row[LODGE_DATA::TEL],row[LODGE_DATA::HOMPAGE_ADDR],
                                                row[LODGE_DATA::LATITUDE],row[LODGE_DATA::LONGITUDE],row[LODGE_DATA::DATA_STANDARD_DATE]))
              
                end
            end
        end
  
        if loadge_arr.size ===0
            return nil
        else
            return loadge_arr
        end
    end
    
    def getForestLodageData_NameAndLocation(name,location)
         book = Spreadsheet.open((Dir.pwd).concat('/data/lodge/forestlodge.xls'))

        
        loadge_arr = Array.new
    
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            if index!=0
                if(row[LODGE_DATA::NAME].include?(name) && row[LODGE_DATA::ADDRESS].include?(location))
                loadge_arr.push(ForestLodge.new(row[LODGE_DATA::NAME],row[LODGE_DATA::STATE],row[LODGE_DATA::CLASSIFICATION],row[LODGE_DATA::SIZE],
                                                row[LODGE_DATA::AVAILPEOPLE],row[LODGE_DATA::ENTERENCE_FEE],row[LODGE_DATA::IS_STAY],row[LODGE_DATA::MAJOR_FACILITIE],
                                                row[LODGE_DATA::ADDRESS],row[LODGE_DATA::MANAGEMENT],row[LODGE_DATA::TEL],row[LODGE_DATA::HOMPAGE_ADDR],
                                                row[LODGE_DATA::LATITUDE],row[LODGE_DATA::LONGITUDE],row[LODGE_DATA::DATA_STANDARD_DATE]))
          
                end
            end
        end
  
        if loadge_arr.size ===0
            return nil
        else
            return loadge_arr
        end
    end
    
    
    
    
    def MakeForestLodageData.create    
        @@object = new unless @@object   
        return @@object
    end

end