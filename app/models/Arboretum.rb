require 'nokogiri' # 파싱 젬
require ('open-uri') # url 요청


class Arboretum
    private
        @name = nil
        @address = nil
        @size = nil
        @plants_numbers = nil
        @start_date = nil
        @tel = nil
        @content = nil
        @homepage_addr = nil
        @related_link = nil
        #@howtogo = nil
    
    public
    
    def initialize(name,address,size,plants_numbers,start_date,tel,related_link)
        @name = name
        @address = address
        @size = size
        @plants_numbers = plants_numbers
        @start_date = start_date
        @tel = tel
        @related_link = related_link
     
    end
    
    def getName
        return @name
    end
    
    def getAddress
        return @address
    end
    
    def getSize
        return @size
    end
    
    def getPlants_numbers
        return @plants_numbers
    end
    
    def getStart_date
        return @start_date
    end
    
    def getTel
        return @tel
    end
    
    def getContent
        return @content
    end
    
    def getHomePageAddr
        return @homepage_addr
    end
    
    def setContent(content)
        @content = content
    end
    
    def setHompageAddr(hompage)
        @homepage_addr = homepage_add
    end
    
    def getRelatedLink
        return @related_link
    end
    
    

end

class MakeArboretumData
    private_class_method :new    
    @@object = nil
    
    
    
    public
    
    def getAllArboretumData
        html_doc = Nokogiri::HTML(open('http://www.forest.go.kr/newkfsweb/html/HtmlPage.do?pg=/foreston/fon_arboretum/foreston_0101.html&orgId=fon&mn=KFS_01_03_01').read)
       
        arboretumDataArr = Array.new
       
        datas = html_doc.css('tbody')
    
        datas.each_with_index do|data,index|
            current_table = data.css('tr')
            current_table.each do|row|
                #puts row
                #puts '-------------------------------------------------------------------'
                name = row.at_css('th span a').text.strip
                address = row.at_css('td.left').text.strip #주소
                tel = row.at_css('td.t_end').text.strip
                extra_data = row.css('td')
                size = extra_data[1].text#규모
                plants_numbers = extra_data[2].text#보유종
                start_date =  extra_data[3].text#등록일
            
                
                related_link = row.at_css('th span a[href]')['href']# 연결되어있는 주소
                
                object = Arboretum.new(name,address,size,plants_numbers,start_date,tel,related_link)
                #puts object.getAddress
                arboretumDataArr.push(object)
            
            end
            
        end
        
        return arboretumDataArr
    end
    
    def getContentAndHomeaddress(url) # 연관된 주소로 홈페이지및 내용 가져오는 함수 한꺼번에 가져올려고 하면 너무 오래걸림
        c_h_addarr = Array.new
        html_doc = Nokogiri::HTML(open('http://www.forest.go.kr'.concat(url)).read)
        
        c_h_addarr.push(html_doc.css('div.partic_con p').text.delete "홈페이지 바로가기")
        c_h_addarr.push(html_doc.at_css('div p a')['href'])
        
        return c_h_addarr # 0은 내용 1은 해당 수목원 홈페이지 주소
    end
    
    def getArboretum_withName(name)
        arboretums = getAllArboretumData
        
        
        result_arr = Array.new
        arboretums.each do|arboretum|
            if arboretum.getName.include?(name)
                result_arr.push(arboretum)
            end
        end
        
        if result_arr.size===0
            return nil
        else
            return result_arr
        end
    end
    
    def getArboretum_withAdress(address)
        arboretums = getAllArboretumData
        
        
        result_arr = Array.new
        arboretums.each do|arboretum|
            if arboretum.getAddress.include?(address)
                result_arr.push(arboretum)
            end
        end
        
        if result_arr.size===0
            return nil
        else
            return result_arr
        end
    end
    
    def getArboretum_withNameAndAddress(name,address)
        arboretums = getAllArboretumData
        
        
        result_arr = Array.new
        arboretums.each do|arboretum|
            if arboretum.getAddress.include?(address) && arboretum.getName.include?(name)
                result_arr.push(arboretum)
            end
        end
        
        if result_arr.size===0
            return nil
        else
            return result_arr
        end
    end
    
    
    

    def MakeArboretumData.create    
        @@object = new unless @@object   
        return @@object
    end
end