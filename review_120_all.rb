# frozen_string_literal: true
#口コミの文章全文＋ローカルガイドの情報を取得→120件分

require 'selenium-webdriver'
require 'pry'

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(timeout: 100)

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&sxsrf=ALeKk03piFZiTXDS_S-GwnYVa4JmAemjuA%3A1613137898660&ei=6ocmYKfoJ4H3hwPrv4WYBg&q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBAgjECcyAggAMgIIADICCAAyAggAMgIIADICCAA6BwgjELADECc6BwgAEEcQsAM6CAgAELEDEIMBOgQIABAEOgQIABAeOgYIABAIEB5QjhtYmSdg3CloAXACeACAAegBiAGdD5IBBTAuOC4zmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwinhbH7vuTuAhWB-2EKHetfAWMQ4dUDCA0&uact=5#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')

wait.until { d.find_element(:xpath, '//*[@id="reviewSort"]/div/div[2]/div[2]/div[1]/div[3]/div[2]/span').displayed? }

# スクロール関連 11回スクロール→口コミ120件分読み込まれる============================================
review_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height
sleep 3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,3000)')
sleep 3
review_height2 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height2
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,6000)')
sleep 3
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3

d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,9000)')
sleep 3
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,12000)')
sleep 3
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,15000)')
sleep 10
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,18000)')
sleep 10
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,21000)')
sleep 10
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,24000)')
sleep 10
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,27000)')
sleep 10
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,30000)')
sleep 10
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,33000)')
sleep 10
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3
#============================================

review_total 
elements = d.find_elements(:class_name, 'gws-localreviews__google-review')
elements.each.with_index(1) do |element, index|
    puts "-----#{index}番目-----"
    #puts element.text
    #:class_name, 'Jtu6Td'→口コミ文章部分 「ローカルガイド · 40 件のレビュー · 297 枚の写真」部分はとは別のクラス（別のdivで囲われている）
    review_item = element.find_element(:class_name, 'Jtu6Td')
    local_guide = element.find_element(:class_name, 'FGlxyd')
    begin
        # まず、 review-full-text というクラス名の要素を持つ（= もっと見るが表示されている）
        # という前提で進める
        review_item.find_element(:class_name, 'review-more-link').click
        sleep 0.5
        content = review_item.find_element(:class_name, 'review-full-text')
        local_guide_info = local_guide.find_element(:class_name, 'A503be')
        puts local_guide_info.text
        puts content.text
      rescue StandardError
        # review-full-text がなかったら、最後のspan要素を出力する
        content = review_item.find_elements(:tag_name, 'span').last
        local_guide_info = local_guide.find_element(:class_name, 'A503be')
        puts local_guide_info.text
        puts content.text
      end
end