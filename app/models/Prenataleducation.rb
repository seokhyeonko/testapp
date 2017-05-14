require 'nokogiri' # 파싱 젬
require ('open-uri') # url 요청
require 'date' #날 짜

=begin
    모든 크롤링 및 데이터 요청은 그때 그때마다 다시 요청해서 데이터를 받고 있다 -> 지속적인 딜레이발생
    루비가 클래스를 어떻게 처리하는지 몰라 우선은 그때그때 요청하게 만듬.
    후에 서비스 런칭시 현재 세션에서 한번 요청한 데이터라면 요청하지말고 기존 데이터에서 처리하게 만드는 것이
    주요할듯
=end

#문의 전화 번호 추가로 넣어줘야 할수도 있음 -> 운영계획 참고해서 나중에 넣기


class Prenataleducation
    private
        @title = nil
        @location = nil
        @education_date = nil
        @is_apply = nil
        @education_time = nil
        @content = nil
        @link = nil
        @entry_fee = nil
        @education_time_string = nil
        @address = nil
        @year = nil
        @month = nil
        @day = nil
        
    public
    def initialize(title,location,education_date,is_apply,link,year,month,day)
        @title = title
        @location = location
        @education_date = education_date
        @is_apply = is_apply
        @education_time = 3
        @education_time_string = '13:30~16:30(3시간)'
        @link = link
        @content = '명상, 호흡, 자연물관찰, 자연물공예 등(현장여건에 따라 변경될 수 있음)'
        @entry_fee = '무료'
        @year = year
        @month = month
        @day = day
        
    end
    
    def getTitle
        return @title
    end
    
    def getLocation
        return @location
    end
    
    def getEducationDate
        return @education_date
    end
    
    def getIsApply
        return @is_apply # 신청가능 or 마감
    end
    
    def getSpendTime
        return @education_time
    end
    
    def getEducationTimeString
        return @education_time_string
    end
    
    def getLink
        return @link
    end
    
    def getContent
        return @content
    end
    
    def getEntryFee
        return @entry_fee
    end
    
    def getYear
        return @year
    end
    
    def getMonth
        return @month
    end
    
    def getDay
        return @day
    end
  
end

class MakePrenataleducationData
    private_class_method :new    
    @@object = nil
    
    
    
    public
    def getAllPrenatalEducation
       url = 'http://www.forest.go.kr/newkfsweb/kfi/kfs/forestedu/selectForestEduList.do?pageIndex='
       t_year = Time.now.strftime("%Y").to_i
       t_month = Time.now.strftime("%m").to_i
       t_day = Time.now.strftime("%d").to_i
       
       prentalEducationDataArr = Array.new
       
       is_outday_data = false
       
       
       for i in 1..10
            if is_outday_data
                break
            end
            
            c_url = url + i.to_s
            html_doc = Nokogiri::HTML(open(c_url).read)
            table_datas = html_doc.css('tbody tr')
            
            #puts table_datas
            
            table_datas.each do|row|
                   data_arr = row.css('td') 
                   
                   title = data_arr[1].text
                   location = data_arr[2].text
                   
                   #날짜 파싱
                   date = data_arr[3].text
                   date_year = date[0..3].to_i
                   date_month = date[4..5].to_i
                   date_day = date[6..7].to_i
                   
                  
                   
                   is_end = data_arr[5].text.strip
                   if is_end.include?('마감')
                       is_end = '마감'
                   else
                       is_end = '신청가능'
                   end
                   
                   #신청가능일 자인지 아닌지 판별
                   if date_year < t_year
                       is_outday_data = true
                       break
                   end
                   
                   if date_year === t_year && date_month < t_month
                       is_outday_data = true
                       break
                   end
                   
                   if date_year === t_year && date_month === t_month && date_day < t_day
                        is_outday_data = true
                        break
                   end
                  
                   prentalEducationDataArr.push(Prenataleducation.new(title,location,date,is_end,c_url,date_year,date_month,date_day))
                       
                   
                   #puts is_end
                   #puts '-----------------------------------------'    
            end
       end
       
       if prentalEducationDataArr.size === 0
           return nil
       end
       
        return prentalEducationDataArr

    end
    
    #어차피 숲 태교 데이터는 4월 ~ 10월중에 만이뤄지고 주 토요일마다 진행중 따라서 정확한 날짜가 의미가 없음. 달로만 조회 가능
    def getPrenatalEducationWith_month(month) 
        datas = getAllPrenatalEducation
        
        if datas == nil
            return nil
        end
        
        #string 값이 들어오는 경우대비
        mon = month.to_i
        result = Array.new
        datas.each do|data|
            if data.getMonth===mon
                result.push(data)
            end
        end
    
        if result.size === 0
            return nil
        end
        
         return result
    end
    
    #세부 위치정보가 아니여서 나중에 수정해야할 가능성 있음!
    def getPrenatalEducationWith_location(location)
        datas = getAllPrenatalEducation
        if datas == nil
            return nil
        end
        
        result = Array.new
        datas.each do|data|
            if data.getLocation.include?(location)
                result.push(data)
            end
        end
    
        if result.size === 0
            return nil
        end
        
         return result
    
    end
    
    def getPrenatalEducationWith_MonthAndLocation(month,location)
         datas = getAllPrenatalEducation
         
       if datas == nil
            return nil
        end
       #string 값이 들어오는 경우대비
        mon = month.to_i
        
        result = Array.new
        datas.each do|data|
            if data.getLocation.include?(location) && data.getMonth===mon
                result.push(data)
            end
        end
    
        if result.size === 0
            return nil
        end
        
         return result
    end
    

    def MakePrenataleducationData.create    
        @@object = new unless @@object   
        return @@object
    end
end