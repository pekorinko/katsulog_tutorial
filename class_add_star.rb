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

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&sxsrf=ALeKk03piFZiTXDS_S-GwnYVa4JmAemjuA%3A1613137898660&ei=6ocmYKfoJ4H3hwPrv4WYBg&q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBAgjECcyAggAMgIIADICCAAyAggAMgIIADICCAA6BwgjELADECc6BwgAEEcQsAM6CAgAELEDEIMBOgQIABAEOgQIABAeOgYIABAIEB5QjhtYmSdg3CloAXACeACAAegBiAGdD5IBBTAuOC4zmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwinhbH7vuTuAhWB-2EKHetfAWMQ4dUDCA0&uact=5#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')

#口コミページが表示されるまで待つ
wait.until { d.find_element(:class_name, 'lcorif').displayed? }

#スクロールをループで書く
current_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
elements = []

while true do
    #口コミを変数に入れる
    #'gws-localreviews__google-review' 口コミ１件の全体
    elements = d.find_elements(:class_name, 'gws-localreviews__google-review')
    #elementsに入っている口コミの件数が30件以上であればループを抜ける
    if elements.length >= 30
        break
    end
    #elementsに入っている口コミの件数が30件未満であれば、更に今表示されている画面の一番下までスクロール
    d.execute_script("document.getElementsByClassName('review-dialog-list')[0].scrollTo(0,#{current_height})")
    sleep 5
    current_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
    sleep 5
end

puts elements.length

reviews = []

elements.each do |element|
    #:class_name, 'Jtu6Td'→口コミ文章部分 
    review_item = element.find_element(:class_name, 'Jtu6Td')
    local_guide = element.find_element(:class_name, 'FGlxyd')
    star_score = element.find_element(:class_name,"PuaHbe").find_element(:class_name,"Fam1ne").attribute('aria-label').scan(/\d+\.\d+?/)[0].to_f
    
    # binding.pry
    p star_score

    begin
        # まず、 review-full-text というクラス名の要素を持つ（= もっと見るが表示されている）
        # という前提で進める
        review_item.find_element(:class_name, 'review-more-link').click
        sleep 0.5
        content = review_item.find_element(:class_name, 'review-full-text')
        local_guide_info = local_guide.find_element(:class_name, 'A503be')
        

        review = Review.new(content.text,local_guide_info.text.match(/(\d+)\ 件のレビュー/)[1].to_i, star_score)
        reviews.push(review)
        # puts local_guide_info.text
        # puts content.text
      rescue StandardError
        # review-full-text がなかったら、最後のspan要素を出力する
        content = review_item.find_elements(:tag_name, 'span').last
        local_guide_info = local_guide.find_element(:class_name, 'A503be')
        

        review = Review.new(content.text,local_guide_info.text.match(/(\d+)\ 件のレビュー/)[1].to_i, star_score)
        reviews.push(review)
        # puts local_guide_info.text
        # puts content.text
      end
end

reviews.each.with_index(1) do |review,index|
    puts "-----#{index}番目-----"
    puts review.text
    puts review.count
    puts review.star
end