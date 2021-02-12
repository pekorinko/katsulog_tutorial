
require 'selenium-webdriver'

d = Selenium::WebDriver.for :chrome

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&sxsrf=ALeKk03piFZiTXDS_S-GwnYVa4JmAemjuA%3A1613137898660&ei=6ocmYKfoJ4H3hwPrv4WYBg&q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBAgjECcyAggAMgIIADICCAAyAggAMgIIADICCAA6BwgjELADECc6BwgAEEcQsAM6CAgAELEDEIMBOgQIABAEOgQIABAeOgYIABAIEB5QjhtYmSdg3CloAXACeACAAegBiAGdD5IBBTAuOC4zmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwinhbH7vuTuAhWB-2EKHetfAWMQ4dUDCA0&uact=5#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')

#bodyの高さ
#execute_script（）の（）の中にはJavascriptが入っている
#https://www.rubydoc.info/gems/selenium-webdriver/0.0.28/Selenium%2FWebDriver%2FDriver:execute_script
# body_height = d.execute_script("return document.body.scrollHeight")
# puts body_height

sleep 3
#口コミ一覧のスクロールエリアの高さ
review_height = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height

sleep 3
d.execute_script('document.getElementsByClassName("review-dialog-list")[0].scrollTo(0,3000)')
sleep 3

review_height2 = d.execute_script('return document.getElementsByClassName("review-dialog-list")[0].scrollHeight')
puts review_height2

sleep 30