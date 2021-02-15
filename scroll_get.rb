#スクロールして10個目の口コミまで取得できた
#参考　https://teratail.com/questions/234189


require 'selenium-webdriver'

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(:timeout => 100)

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&sxsrf=ALeKk03piFZiTXDS_S-GwnYVa4JmAemjuA%3A1613137898660&ei=6ocmYKfoJ4H3hwPrv4WYBg&q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBAgjECcyAggAMgIIADICCAAyAggAMgIIADICCAA6BwgjELADECc6BwgAEEcQsAM6CAgAELEDEIMBOgQIABAEOgQIABAeOgYIABAIEB5QjhtYmSdg3CloAXACeACAAegBiAGdD5IBBTAuOC4zmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwinhbH7vuTuAhWB-2EKHetfAWMQ4dUDCA0&uact=5#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')

wait.until  {d.find_element(:xpath, '//*[@id="reviewSort"]/div/div[2]/div[2]/div[1]/div[3]/div[2]/span').displayed?}

#スクロール関連
review_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height
sleep 3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,10000)')
sleep 3
review_height2 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height2
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,20000)')
sleep 10
review_height3 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height3

index = 0

while index < 20 do
    index = index + 1
    puts "index = #{index}"
    wait.until  {
        #d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,10000)')
        d.find_element(:xpath, "//*[@id='reviewSort']/div/div[2]/div[#{index}]/div[1]/div[3]/div[2]/span").displayed?
    }
    #指定したxpathまでスクロールするように挙動させたい
    puts d.find_element(:xpath, "//*[@id='reviewSort']/div/div[2]/div[#{index}]/div[1]/div[3]/div[2]/span").text
    puts "============================"
    sleep 2
end

sleep 3