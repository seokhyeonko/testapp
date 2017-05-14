require 'spreadsheet'


#대상 종류
# 유아, 전체, 초등학생, 청소년,일반
#숲 해설 데이터는 카테고리,대상, 날짜, 카테고리/대상, 카테고리/날짜... 모든 경우에대해서 다 처리
# 기능은 대상, 날짜, 대상/날짜로 보여줘야 할 수 있음
#추가
#위치, 위치/대상, 위치/날짜, 위치/대상/날짜 ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ아 많다ㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠㅠ살려줘



module M_EXPALIN_DATA
  FACILITY = 2 #시설
  FACILITY_NAME = 3 #시설명
  ADDRESS = 4 #주소
  MANAGEMENT_PERIOD=5 #운영기간
  TEL=6 #전화번호
  JOIN_METHOD=7 # 참여방법
  TARGET=8 #대상
end



class MountainExpalin 
    private
    @facility = nil
    @facility_name = nil
    @address = nil
    @management_period = nil
    @tel = nil
    @join_method = nil
    @target = nil
    
    
    def initialize(facility,facility_name,address,tel,join_method,target)
        @facility = facility
        @facility_name = facility_name
        @address = address
        @management_period = [0,0,0,0,0,0,0,0,0,0,0,0,0]
        @tel = tel
        @join_method = join_method
        @target = target
      
    end
    
    public
    
    def getFacility
        return @facility
    end
    
    def getFacilityName
        return @facility_name    
    end
    
    def getAddress
        return @address   
    end
    
    def getTel
        return @tel
    end
    
    def getJoinMethod
        return @join_method
    end
    
    def getTarget
        return @target
    end
    
    def getManagementPeriod
        return @management_period
    end
    
    def isManagementPeriod_withMonth(month)
       month = month.to_i
       if @management_period[month] === 1
           return true
       end
       return false
    end
    
    def setManageMentPeriod(month)
       month = month.to_i
       @management_period[month] = 1
    end
    
    def setManageMentPeriod(arr)
        @management_period = arr
    end
    
    def find_refined_data(args)
        exclude_string = args[:exclude];
        new_results = do_some_work_and_exclude_records(@results,exclude_string)
    end
        
end



class MakeMountainExpalinData
    private_class_method :new    
    @@object = nil
    
    private
    def isManagementPeriod() 
        
        
        
        return
    end
    
    def checkAndSetPeriodData(str)
        #2이하면 무조건 연중 수시
        #3이상이라면 봄~가을 아니면 숫자 월
        mp = [0,0,0,0,0,0,0,0,0,0,0,0,0]
        #t = d1.split('~')
        #puts t[0].split('월')
        #puts d2.size
        #puts d3.size
        #puts d4.size
        #t = d5.split('~')
        #puts t[1].split('월')
        #이걸로 판별해서 숫자인지 아닌지 숫자가 아니면 ->봄 또는 여름임
        #숫자이면 반목문 돌려서 세팅
        size_str = str.size
        
        if size_str<=2 # 연중 혹은 수시
            if(str.include?('연중')) 
                mp = [0,1,1,1,1,1,1,1,1,1,1,1,1]
            end
        else # 봄 or 숫자
            str_temp = str.split('~')
     
            str_front = str_temp[0].split('월')
            str_back = str_temp[1].split('월')
        
            is_str = str_front[0] =~ /\A\d+\z/ ? true : false
            
            #숫자면 트루
         
            if is_str #만약 숫자라면 3~12월 데이터임
                str_front = str_front[0].to_i
                str_back = str_back[0].to_i
                
                for i in str_front..str_back
                    mp[i] = 1
                end
                    
            else # 만약 봄,여름이라면 봄~여름 등 데이터임
                if str_front.include?('봄')
                    str_front = 3
                else
                    str_front = 6
                end
                
                if str_back.include?('가을')
                    str_back = 11
                    for i in str_front..str_back
                        mp[i] = 1
                    end
                else# 겨울
                    str_back = 12
                    for i in str_front..str_back
                        mp[i] = 1
                    end
                    
                    mp[1] = 1
                    mp[2] = 1
                end
                
            end
            
        end
        
        
    
        return mp
    end
    

    public
    def getAllMountainExpalinData
        
        book = Spreadsheet.open((Dir.pwd).concat('/data/mountain_explain/mountaion_explain.xls'))
        m_explain_arr = Array.new
        
        
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0 
                mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                   row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                p_arr = checkAndSetPeriodData(period)
                mob.setManageMentPeriod(p_arr)
                m_explain_arr.push(mob)
            end
        end
  
       if m_explain_arr.size ===0
            return nil
        else
            return m_explain_arr
        end
    
    end
    
    #대상으로 검색 유아, 전체, 초등학생, 청소년,일반
    def getMountainExpalinData_withTarget(target)
        
        book = Spreadsheet.open((Dir.pwd).concat('/data/mountain_explain/mountaion_explain.xls'))
        m_explain_arr = Array.new
        
        if target.include?('고등학생')
            target = target.concat(',청소년')
        end
        
        target_arr = target.split(',')
       
        
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0 
                target_temp = row[M_EXPALIN_DATA::TARGET]
                flag = 0
                if target_temp.include?('전체')
                    mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                   row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                
                                   
                                   
                    period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                    p_arr = checkAndSetPeriodData(period)
                    mob.setManageMentPeriod(p_arr)
                    flag =1
                    m_explain_arr.push(mob)
                end
                
                target_arr.each do |t|
                     if target_temp.include?(t) && flag==0
                         mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                       row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                    
                                       
                                       
                        period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                        p_arr = checkAndSetPeriodData(period)
                        mob.setManageMentPeriod(p_arr)
                        flag =1
                        m_explain_arr.push(mob)
                    end
                end
       
                
                
            end
        end
  
       if m_explain_arr.size ===0
            return nil
        else
            return m_explain_arr
        end
    
    end
    
    #날짜로 검색
    def getMountainExpalinData_witDate(month)
        
        book = Spreadsheet.open((Dir.pwd).concat('/data/mountain_explain/mountaion_explain.xls'))
        m_explain_arr = Array.new
        
        
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0 
                
                period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                p_arr = checkAndSetPeriodData(period)
                
                if p_arr[month] ===1
                    mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                   row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                    mob.setManageMentPeriod(p_arr)
                    m_explain_arr.push(mob)
                end
            end
        end
  
       if m_explain_arr.size ===0
            return nil
        else
            return m_explain_arr
        end
    
    end
    
    #대상,날짜 검색
    def getMountainExpalinData_withTargetAndDate(target,month)
        
        book = Spreadsheet.open((Dir.pwd).concat('/data/mountain_explain/mountaion_explain.xls'))
        m_explain_arr = Array.new
        
        if target.include?('고등학생')
            target = target.concat(',청소년')
        end
        
        target_arr = target.split(',')
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0 
 
                period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                p_arr = checkAndSetPeriodData(period)
              
                if p_arr[month] ===1
                    target_temp = row[M_EXPALIN_DATA::TARGET]
                    flag = 0
                    if target_temp.include?('전체')
                        mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                       row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                    
                                       
                                       
                        period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                        p_arr = checkAndSetPeriodData(period)
                        mob.setManageMentPeriod(p_arr)
                        flag =1
                        m_explain_arr.push(mob)
                    end
                        
                    target_arr.each do |t|
                         if target_temp.include?(t) && flag==0
                             mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                           row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                        
                                           
                                           
                            period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                            p_arr = checkAndSetPeriodData(period)
                            mob.setManageMentPeriod(p_arr)
                            flag =1
                            m_explain_arr.push(mob)
                        end
                    end
                end
                    
                
            end
        end
  
       if m_explain_arr.size ===0
            return nil
        else
            return m_explain_arr
        end
    
    end
    
    def getMountainExpalinData_withLocation(location)
        
        book = Spreadsheet.open((Dir.pwd).concat('/data/mountain_explain/mountaion_explain.xls'))
        m_explain_arr = Array.new
        
        
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0 
                location_temp = row[M_EXPALIN_DATA::ADDRESS]
                if location_temp.include?(location)
                    
                    mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                       row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                    period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                    p_arr = checkAndSetPeriodData(period)
                    mob.setManageMentPeriod(p_arr)
                    m_explain_arr.push(mob)
                end
            end
        end
  
       if m_explain_arr.size ===0
            return nil
        else
            return m_explain_arr
        end
    
    end
    
    def getMountainExpalinData_withLocationAndMonth(location,month)
        
        book = Spreadsheet.open((Dir.pwd).concat('/data/mountain_explain/mountaion_explain.xls'))
        m_explain_arr = Array.new
        
        
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0 
                location_temp = row[M_EXPALIN_DATA::ADDRESS]
                if location_temp.include?(location)
                    
                    period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                     p_arr = checkAndSetPeriodData(period)
            
                    if p_arr[month] ===1
                        mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                  row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                        mob.setManageMentPeriod(p_arr)
                        m_explain_arr.push(mob)
                    end
                end
            end
        end
  
       if m_explain_arr.size ===0
            return nil
        else
            return m_explain_arr
        end
    
    end
    
    def getMountainExpalinData_withLocationAndTarget(location,target)
        
        book = Spreadsheet.open((Dir.pwd).concat('/data/mountain_explain/mountaion_explain.xls'))
        m_explain_arr = Array.new
        
        if target.include?('고등학생')
            target = target.concat(',청소년')
        end
        
        target_arr = target.split(',')
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0 
                location_temp = row[M_EXPALIN_DATA::ADDRESS]
                if location_temp.include?(location)
                    target_temp = row[M_EXPALIN_DATA::TARGET]
                    flag = 0
                    if target_temp.include?('전체')
                        mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                       row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                    
                                       
                                       
                        period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                        p_arr = checkAndSetPeriodData(period)
                        mob.setManageMentPeriod(p_arr)
                        flag =1
                        m_explain_arr.push(mob)
                    end
                        
                    target_arr.each do |t|
                         if target_temp.include?(t) && flag==0
                             mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                           row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                        
                                           
                                           
                            period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                            p_arr = checkAndSetPeriodData(period)
                            mob.setManageMentPeriod(p_arr)
                            flag =1
                            m_explain_arr.push(mob)
                        end
                    end
                    
                end
            end
        end
  
       if m_explain_arr.size ===0
            return nil
        else
            return m_explain_arr
        end
    
    end
    
        
    def getMountainExpalinData_withAllCheck(location,month,target)
        book = Spreadsheet.open((Dir.pwd).concat('/data/mountain_explain/mountaion_explain.xls'))
        m_explain_arr = Array.new
        
        if target.include?('고등학생')
            target = target.concat(',청소년')
        end
        
        target_arr = target.split(',')
        
        sheet = book.worksheet(0) # can use an index or worksheet name
        sheet.each_with_index do |row,index|
            break if row[0].nil? # if first cell empty
            #puts row.join(',') # looks like it calls "to_s" on each cell's Value
            
            if index!=0 
                location_temp = row[M_EXPALIN_DATA::ADDRESS]
                period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                p_arr = checkAndSetPeriodData(period)
               
                if location_temp.include?(location) && p_arr[month] ===1
          
                    target_temp = row[M_EXPALIN_DATA::TARGET]
                    flag = 0
                    if target_temp.include?('전체')
                        mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                       row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                    
                                       
                                       
                        period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                        p_arr = checkAndSetPeriodData(period)
                        mob.setManageMentPeriod(p_arr)
                        flag =1
                        m_explain_arr.push(mob)
                    end
                        
                    target_arr.each do |t|
                         if target_temp.include?(t) && flag==0
                             mob = MountainExpalin.new(row[M_EXPALIN_DATA::FACILITY],row[M_EXPALIN_DATA::FACILITY_NAME],row[M_EXPALIN_DATA::ADDRESS],
                                           row[M_EXPALIN_DATA::TEL],row[M_EXPALIN_DATA::JOIN_METHOD],row[M_EXPALIN_DATA::TARGET])
                        
                                           
                                           
                            period = row[M_EXPALIN_DATA::MANAGEMENT_PERIOD]
                            p_arr = checkAndSetPeriodData(period)
                            mob.setManageMentPeriod(p_arr)
                            flag =1
                            m_explain_arr.push(mob)
                        end
                    end
                end
            end
        end
  
       if m_explain_arr.size ===0
            return nil
        else
            return m_explain_arr
        end
    
    end
    
    
    
    
    
    
    def MakeMountainExpalinData.create    
        @@object = new unless @@object   
        return @@object
    end

end