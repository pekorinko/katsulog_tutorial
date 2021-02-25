#平塚の美容院→ローカルガイドじゃないとうこうしかない店舗

require 'selenium-webdriver'
require 'pry'

class Review
    #口コミの文章部分を @review_text に代入する
    def initialize(text, count, star)
        @text = text
        @count = count
        @star = star
    end
    #@review_text に代入された口コミの文章部分を返す
    def text
        @text
    end
    def count
        @count
    end
    def star
        @star
    end

end

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(timeout: 100)

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&biw=1080&bih=574&tbm=lcl&ei=NVk3YJ-JD4GvoASZtoy4DA&q=%E5%B9%B3%E5%A1%9A%E3%80%80%E7%BE%8E%E5%AE%B9%E9%99%A2&oq=%E5%B9%B3%E5%A1%9A%E3%80%80%E7%BE%8E%E5%AE%B9%E9%99%A2&gs_l=psy-ab.3..0i7i30k1l8.87128.89315.0.89847.12.12.0.0.0.0.182.1378.3j8.11.0....0...1c.1j4.64.psy-ab..6.5.710...0j0i67k1j0i7i4i30k1.0.m96OrDiFWGs#lrd=0x6019acd8a79c5fb5:0x99f75ae1b56fbb69,1,,,&rlfi=hd:;si:11094436132508646249,l,ChLlubPloZrjgIDnvo7lrrnpmaJaIwoK576O5a65IOmZoiIR5bmz5aGaIOe-juWuuSDpmaIqAggDkgEKaGFpcl9zYWxvbqoBEhABKg4iCue-juWuuSDpmaIoCA;mv:[[35.3525839,139.3576149],[35.3243199,139.31230779999999]];start:20')
sleep 5
#口コミページが表示されるまで待つ
wait.until { d.find_element(:class_name, 'lcorif').displayed? }

# elements = []
# elements = d.find_elements(:class_name, 'gws-localreviews__google-review')
# # elements.find_elements(:class_name, 'FGlxyd')[0].find_elements(:class_name, 'A503be')[0].empty? 

elements = []
reviews = []
elements = d.find_elements(:class_name, 'gws-localreviews__google-review')

elements.each do |element|
    #:class_name, 'Jtu6Td'→口コミ文章部分 
    review_item = element.find_element(:class_name, 'Jtu6Td')
    local_guide = element.find_element(:class_name, 'FGlxyd')
    star_score = element.find_element(:class_name,"PuaHbe").find_element(:class_name,"Fam1ne").attribute('aria-label').scan(/\d+\.\d+?/)[0].to_f

    # element.find_elements(:class_name, 'FGlxyd').find_elements(:class_name, 'A503be').empty? 

end

