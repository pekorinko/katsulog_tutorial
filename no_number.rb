#口コミ１件目のxpathが来るまで待つ→口コミ１件目が無かったら待たない

require 'selenium-webdriver'
require 'pry'

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(timeout: 100)

d.get('https://www.google.com/search?rlz=1C5CHFA_enJP939JP939&sxsrf=ALeKk03piFZiTXDS_S-GwnYVa4JmAemjuA%3A1613137898660&ei=6ocmYKfoJ4H3hwPrv4WYBg&q=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&oq=%E6%B9%AF%E6%A5%BD%E3%81%AE%E9%87%8C%E3%80%80%E5%9B%BD%E7%AB%8B&gs_lcp=Cgdnd3Mtd2l6EAMyBAgjECcyBAgjECcyAggAMgIIADICCAAyAggAMgIIADICCAA6BwgjELADECc6BwgAEEcQsAM6CAgAELEDEIMBOgQIABAEOgQIABAeOgYIABAIEB5QjhtYmSdg3CloAXACeACAAegBiAGdD5IBBTAuOC4zmAEAoAEBqgEHZ3dzLXdpesgBCsABAQ&sclient=gws-wiz&ved=0ahUKEwinhbH7vuTuAhWB-2EKHetfAWMQ4dUDCA0&uact=5#lrd=0x6018e3951c8fde6f:0x429b84dcae3b48f6,1,,,')
sleep 5
#binding.pry
#中身を待つのでもOKだが口コミページ全体が表示されるのを待つでも良いのでは無いか？
wait.until { d.find_elements(:class_name, 'WMbnJf')[1].displayed? }

