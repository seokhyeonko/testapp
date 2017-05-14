require 'spreadsheet'

module ECO_DATA
  CODE = 0 #마을 코드
  NAME = 1 #마을 이름
  ADDRESS = 2 #마을 주소
  X_DOT = 3 #X좌표
  Y_DOT = 4 #Y좌표
end

module ECO_PROGRAM
    CODE = 0 # 마을 코드
    MONTH = 1# 월 
    PROGRAM = 2# 행사
    NAME = 3# 마을 이름
end



class EcoVillage
     private
     @village_code = nil
     @address = nil
     @village_name = nil
     @x = nil
     @y = nil
     @program_hash = nil #1월부터 12월까지의 프로그램 hash 데이터로 저장
     
     
     public
     def initialize(village_code,address,village_name,x,y)
        @village_code = village_code
        @address = address
        @village_name = village_name
        @program_hash = {'1'=>'없음','2'=>'없음','3'=>'없음','4'=>'없음','5'=>'없음','6'=>'없음',
                        '7'=>'없음','8'=>'없음','9'=>'없음','10'=>'없음','11'=>'없음','12'=>'없음'}
        @x = x
        @y = y
     end
     
     def setMonthProgram(month,program)
        mon = month.to_s
        @program_hash[mon] = program
     end
     
     def setYearProgram(hash_data)
        @program_hash = hash_data
     end
     
     def getVillageCode
         return @village_code
     end
     
     def getAddress
        return @address
     end
     
     def getAllProgram
         return @program_hash
     end
     
     def getProgramMonth(month)
        result = @program_hash[month].to_s
        return result.strip
     end
     
     def getX
         return @x
     end
     
     def getY
         return @y
     end
     
     def getName
        return @village_name
     end
    
end

=begin
    프로그램 데이터 3200개정도
    위치 250개 정도
    
    반복문 두개 => 60만번
    
    년도 12월 개소 있음으로 12번마다 배열안에 데이터를 찾아서 세팅해주는 법으로 바꿈
    3200/12 = 260번 * 250 = 최악 63000번 으로 바꿈 -> 나중에 시간 더걸리면 바꿔줘야 함
    
    우선은 전체 데이터를 다 만든후 조회하게 만들 예정이라 굉장히 더 느려질수도 있음 -> 고려해봐야함
    
=end



class MakeEcoVillageData
    private_class_method :new    
    @@object = nil
    
    private
    def makeProgramData(ecovillage_arr)
        
            program_book = Spreadsheet.open((Dir.pwd).concat('/data/ecovillage/eco_village_program.xls'))
            program_sheet = program_book.worksheet(0)
            
            
            pro_hash = {'1'=>'없음','2'=>'없음','3'=>'없음','4'=>'없음','5'=>'없음','6'=>'없음',
                        '7'=>'없음','8'=>'없음','9'=>'없음','10'=>'없음','11'=>'없음','12'=>'없음'}
            
            code = nil
                
                
            program_sheet.each_with_index do |row,index|
                break if row[0].nil?
                code = row[ECO_PROGRAM::CODE]
 
                    
                if index!=0
                    
                    month = row[ECO_PROGRAM::MONTH].to_s
                    #month = month.floor # 잠시 바꿔줬다가
                    month = month.chomp('.0')
                
                    value = pro_hash[month]
                    
                    
                    #기존의 데이터가 들어가 있는지 확인 excel 파일 데이터가 굉장히 지맘대로임
                    if value.eql?('없음')
                        pro_hash[month] = row[ECO_PROGRAM::PROGRAM]
                    else            # 만약 데이터가 들어가 있는 상태라면 글자를 더해서 바꿔주자
                        value = value +","+row[ECO_PROGRAM::PROGRAM]
                        pro_hash[month] = value
                    end
                    
                    #만약 데이터가 더이상 없다면
                    if row[ECO_PROGRAM::MONTH] ===12
                       
                        
                        ecovillage_arr.each do |eco|
                            if eco.getVillageCode.eql?(code)
                                eco.setYearProgram(pro_hash)
                                pro_hash = {'1'=>'없음','2'=>'없음','3'=>'없음','4'=>'없음','5'=>'없음','6'=>'없음',
                                            '7'=>'없음','8'=>'없음','9'=>'없음','10'=>'없음','11'=>'없음','12'=>'없음'}
                                break
                            end
                        end  
                    
                    end
                    
                end
            end
            
            #나머지 것들 한번더
            ecovillage_arr.each do |eco|
                if eco.getVillageCode.eql?(code)
                        eco.setYearProgram(pro_hash)
                            break
                end
            end
      
        return ecovillage_arr
            
    end
    
    
    
    public
    def getAllEcoVillageData
        
        book = Spreadsheet.open((Dir.pwd).concat('/data/ecovillage/eco_villageLocation.xls'))
        ecovillage_arr = Array.new
        
        
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0
                eco_village = EcoVillage.new(row[ECO_DATA::CODE],row[ECO_DATA::ADDRESS],row[ECO_DATA::NAME],row[ECO_DATA::X_DOT],row[ECO_DATA::Y_DOT])
                ecovillage_arr.push(eco_village)
            end
        end
  
       if ecovillage_arr.size ===0
            return nil
        else
            return makeProgramData(ecovillage_arr)
        end
    
    end
    
    def getEcoVillageData_with_location(location)
        
        ecovillage_arr = getAllEcoVillageData
        result_arr = Array.new
        
        
        if ecovillage_arr!=nil
           
           ecovillage_arr.each do|eco|
                if eco.getAddress.include?(location)
                   result_arr.push(eco) 
                end
           end
          
        end
        
        
        if result_arr.size ===0
            return nil
        end
        
        return result_arr
    
    end
    
    def getEcoVillageData_with_month(month)
        month = month.to_s
        
        ecovillage_arr = getAllEcoVillageData
        result_arr = Array.new
        
        
        if ecovillage_arr!=nil
           
           ecovillage_arr.each do|eco|
                if eco.getProgramMonth(month).eql?('없음')===false
                   result_arr.push(eco) 
                end
           end
          
        end
        
        
        if result_arr.size ===0
            return nil
        end
        
        return result_arr
    
    end
    
    def getEcoVillageData_with_monthAndLocation(month,location)
        month = month.to_s
        
        ecovillage_arr = getAllEcoVillageData
        result_arr = Array.new
        
        
        if ecovillage_arr!=nil
           
           ecovillage_arr.each do|eco|
                if eco.getProgramMonth(month).eql?('없음')===false && eco.getAddress.include?(location)
                   result_arr.push(eco) 
                end
           end
          
        end
        
        
        if result_arr.size ===0
            return nil
        end
        
        return result_arr
    
    end
    
    
    
    

    
    
    
    def MakeEcoVillageData.create    
        @@object = new unless @@object   
        return @@object
    end

end


