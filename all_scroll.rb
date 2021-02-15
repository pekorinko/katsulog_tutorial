#スクロールして10個目の口コミまで取得できた
#参考　https://teratail.com/questions/234189


require 'selenium-webdriver'

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(:timeout => 100)

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&sxsrf=ALeKk03piFZiTXDS_S-GwnYVa4JmAemjuA%3A1613137898660&ei=6ocmYKfoJ4H3hwPrv4WYBg&q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBAgjECcyAggAMgIIADICCAAyAggAMgIIADICCAA6BwgjELADECc6BwgAEEcQsAM6CAgAELEDEIMBOgQIABAEOgQIABAeOgYIABAIEB5QjhtYmSdg3CloAXACeACAAegBiAGdD5IBBTAuOC4zmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwinhbH7vuTuAhWB-2EKHetfAWMQ4dUDCA0&uact=5#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')

wait.until  {d.find_element(:xpath, '//*[@id="reviewSort"]/div/div[2]/div[2]/div[1]/div[3]/div[2]/span').displayed?}

#スクロール関連
# review_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
# puts review_height
# sleep 3
# d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,3000)')
# sleep 3
# review_height2 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
# puts review_height2

#スクロールする前の口コミ一覧の高さ（見えている部分）
before_height = d.execute_script("return document.getElementsByClassName('review-dialog-list')[0].scrollHeight")
puts before_height

while true
    #初期のページの高さを10分割して、1/10, 2/10, ..., 10/10の高さに移動するように1/10ずつ加算された高さは height に格納される
    1.step(before_height, before_height/10).each do |height|
        sleep 3
        #1/10高さが加算された位置までスクロールする
        d.execute_script("window.scrollTo(0, #{height})")
    end

    sleep 3

    #１０回スクロールが終わった時点での高さ
    after_height = d.execute_script("return document.getElementsByClassName('review-dialog-list')[0].scrollHeight")

    #before_height（初期のページの高さ）とafter_height（１０回スクロールし終わった時点でのページの高さが同じだったら）
    if after_height == before_height
        break
    end
end




index = 0

while index < 20 do
    index = index + 1
    puts "index = #{index}"
    wait.until  {d.find_element(:xpath, "//*[@id='reviewSort']/div/div[2]/div[#{index}]/div[1]/div[3]/div[2]/span").displayed?}
    #指定したxpathまでスクロールするように挙動させたい
    puts d.find_element(:xpath, "//*[@id='reviewSort']/div/div[2]/div[#{index}]/div[1]/div[3]/div[2]/span").text
    puts "============================"
    sleep 2
end
sleep 3