# #tutorial3.rbとは異なる口コミを抜き出す
# require 'selenium-webdriver'

# d = Selenium::WebDriver.for :chrome

# d.get('https://www.google.com/search?q=%E3%82%A2%E3%83%B3%E3%82%A2%E3%83%9F+%E5%90%89%E7%A5%A5%E5%AF%BA&rlz=1C5CHFA_enJP939JP939&oq=Unami+&aqs=chrome.5.69i57j0l4j0i10l3j0i4l2.4196j0j4&sourceid=chrome&ie=UTF-8#lrd=0x6018ef4af276881d:0x515b56a02750a38d,1,,,')

# d.find_element(:xpath, '//*[@id="reviewSort"]/div/div[2]/div[2]/div[1]/div[3]/div[2]/span').text

# sleep 3

#reviewSort > div > div.gws-localreviews__general-reviews-block > div:nth-child(1) > div.jxjCjc > div:nth-child(4) > div.Jtu6Td > span

require 'selenium-webdriver'

d = Selenium::WebDriver.for :chrome

d.get('https://www.google.com/search?q=%E3%82%A2%E3%83%B3%E3%82%A2%E3%83%9F+%E5%90%89%E7%A5%A5%E5%AF%BA&rlz=1C5CHFA_enJP939JP939&oq=Unami+&aqs=chrome.5.69i57j0l4j0i10l3j0i4l2.4196j0j4&sourceid=chrome&ie=UTF-8#lrd=0x6018ef4af276881d:0x515b56a02750a38d,1,,,')

sleep 3
#指定したxpathまでスクロールするように挙動させたい
puts d.find_element(:xpath, '//*[@id="reviewSort"]/div/div[2]/div[2]/div[1]/div[3]/div[2]/span').text

sleep 3