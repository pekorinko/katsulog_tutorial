#ローカルガイドじゃない口コミで星評価しか無い投稿→ローカルガイドの投稿件数と口コミ本文はとれない

require 'selenium-webdriver'
require 'pry'

class Review
    #口コミの文章部分を @review_text に代入する
    def initialize(text, star)
        @text = text
        # @count = count
        @star = star
    end
    #@review_text に代入された口コミの文章部分を返す
    def text
        @text
    end
    # def count
    #     @count
    # end
    def star
        @star
    end

end

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(timeout: 100)

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&biw=1080&bih=574&tbm=lcl&ei=NVk3YJ-JD4GvoASZtoy4DA&q=%E5%B9%B3%E5%A1%9A%E3%80%80%E7%BE%8E%E5%AE%B9%E9%99%A2&oq=%E5%B9%B3%E5%A1%9A%E3%80%80%E7%BE%8E%E5%AE%B9%E9%99%A2&gs_l=psy-ab.3..0i7i30k1l8.87128.89315.0.89847.12.12.0.0.0.0.182.1378.3j8.11.0....0...1c.1j4.64.psy-ab..6.5.710...0j0i67k1j0i7i4i30k1.0.m96OrDiFWGs#lrd=0x6019acd8a79c5fb5:0x99f75ae1b56fbb69,1,,,&rlfi=hd:;si:11094436132508646249,l,ChLlubPloZrjgIDnvo7lrrnpmaJaIwoK576O5a65IOmZoiIR5bmz5aGaIOe-juWuuSDpmaIqAggDkgEKaGFpcl9zYWxvbqoBEhABKg4iCue-juWuuSDpmaIoCA;mv:[[35.3525839,139.3576149],[35.3243199,139.31230779999999]];start:20')

#口コミページが表示されるまで待つ
wait.until { d.find_element(:class_name, 'lcorif').displayed? }

#スクロールをループで書く
current_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
elements = []
elements = d.find_elements(:css, '.gws-localreviews__google-review.WMbnJf')
# while true do
#     #口コミを変数に入れる
#     #'gws-localreviews__google-review' 口コミ１件の全体
#     elements = d.find_elements(:class_name, 'gws-localreviews__google-review')
#     #elementsに入っている口コミの件数が30件以上であればループを抜ける
#     if elements.length >= 30
#         break
#     end
#     #elementsに入っている口コミの件数が30件未満であれば、更に今表示されている画面の一番下までスクロール
#     d.execute_script("document.getElementsByClassName('review-dialog-list')[0].scrollTo(0,#{current_height})")
#     sleep 5
#     current_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
#     sleep 5
# end

puts elements.length

reviews = []

elements.each do |element|
    #:class_name, 'Jtu6Td'→口コミ文章部分 
    review_item = element.find_element(:class_name, 'Jtu6Td')
    # local_guide = element.find_element(:class_name, 'FGlxyd')
    star_score = element.find_element(:class_name,"PuaHbe").find_element(:class_name,"Fam1ne").attribute('aria-label').scan(/\d+\.\d+?/)[0].to_f
    
    # binding.pry
    p star_score

    begin
        # まず、 review-full-text というクラス名の要素を持つ（= もっと見るが表示されている）
        # という前提で進める
        review_item.find_element(:class_name, 'review-more-link').click
        sleep 0.5
        content = review_item.find_element(:class_name, 'review-full-text')
        # local_guide_info = local_guide.find_element(:class_name, 'A503be')
        

        review = Review.new(content.text, star_score)
        reviews.push(review)
        # puts local_guide_info.text
        # puts content.text
      rescue StandardError
        # review-full-text がなかったら、最後のspan要素を出力する
        content = review_item.find_elements(:tag_name, 'span').last
        # local_guide_info = local_guide.find_element(:class_name, 'A503be')
        

        review = Review.new(content.text, star_score)
        reviews.push(review)
        # puts local_guide_info.text
        # puts content.text
      end
end

reviews.each.with_index(1) do |review,index|
    puts "-----#{index}番目-----"
    puts review.text
    # puts review.count
    puts review.star
end