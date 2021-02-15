# frozen_string_literal: true
#口コミ30件取得→Googleは10件ごと口コミを読み込んでいる→2回スクロールしているため30個口コミを取得出来る

require 'selenium-webdriver'
require 'pry'

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(timeout: 100)

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&sxsrf=ALeKk03piFZiTXDS_S-GwnYVa4JmAemjuA%3A1613137898660&ei=6ocmYKfoJ4H3hwPrv4WYBg&q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBAgjECcyAggAMgIIADICCAAyAggAMgIIADICCAA6BwgjELADECc6BwgAEEcQsAM6CAgAELEDEIMBOgQIABAEOgQIABAeOgYIABAIEB5QjhtYmSdg3CloAXACeACAAegBiAGdD5IBBTAuOC4zmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwinhbH7vuTuAhWB-2EKHetfAWMQ4dUDCA0&uact=5#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')

#1件目の口コミが現れるまで待って
wait.until { d.find_element(:xpath, '//*[@id="reviewSort"]/div/div[2]/div[2]/div[1]/div[3]/div[2]/span').displayed? }

# スクロール関連
#class = "review-dialog-list" は口コミのスクロール出来る部分
review_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height
sleep 3
#Y座標10000までスクロール（スクロール1回目）
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,10000)')
sleep 3
review_height2 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height2
#Y座標20000までスクロール（スクロール2回目）
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,20000)')
sleep 3
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3

# class名がgws-localreviews__google-reviewな要素を取得
#class = 'gws-localreviews__google-review' の範囲：口コミ1件分
elements = d.find_elements(:class_name, 'gws-localreviews__google-review')

#elementに配列の要素1個1個入っていく→eachの中のブロック処理は口コミ1個に対しての処理
elements.each.with_index(1) do |element, index|
  puts "-----#{index}番目-----"
  # ひとつひとつのレビューを review_item という変数に格納する
  #class = 'Jtu6Td' が振られている場所は口コミの文章部分
  review_item = element.find_element(:class_name, 'Jtu6Td')

  begin
    # まず、 review-full-text というクラス名の要素を持つ（= もっと見るが表示されている）
    # という前提で進める
    #review_item はclass = 'Jtu6Td' が振られている所→口コミの文章部分
    #↓class = 'Jtu6Td' の中の (:class_name, 'review-more-link')をクリックしてください
    review_item.find_element(:class_name, 'review-more-link').click
    sleep 0.5
     #↓class = 'Jtu6Td' の中の (:class_name, 'review-full-text')を見つけてください→一つの口コミclass = 'Jtu6Td'につき (:class_name, 'review-full-text')は1個しか無い
    content = review_item.find_element(:class_name, 'review-full-text')
    puts content.text
  rescue StandardError
    # review-full-text がなかったら、最後のspan要素を出力する
    #一つの口コミclass = 'Jtu6Td'につき (:class_name, 'review-full-text')は複数ある
    content = review_item.find_elements(:tag_name, 'span').last
    puts content.text
  end
end
