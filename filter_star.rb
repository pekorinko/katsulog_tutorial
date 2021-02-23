require 'selenium-webdriver'
require 'pry'

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(timeout: 20)

d.get('https://www.google.com/search?q=%E5%8D%97%E8%A1%8C%E5%BE%B3%20%E7%BE%8E%E5%AE%B9%E9%99%A2&rlz=1C5CHFA_enJP939JP939&oq=%E5%8D%97%E8%A1%8C%E5%BE%B3%E3%80%80%E7%BE%8E%E5%AE%B9%E9%99%A2&aqs=chrome.0.69i59j0l8.2958j0j9&sourceid=chrome&ie=UTF-8&tbs=lrf:!1m4!1u3!2m2!3m1!1e1!1m4!1u2!2m2!2m1!1e1!2m1!1e2!2m1!1e3,lf:1,lf_ui:2&tbm=lcl&sxsrf=ALeKk03-xdCjUMoqiGoGe6eTYQPopzxQNA:1614041099234&rflfq=1&num=10&rldimm=11505684056739296527&lqi=ChPljZfooYzlvrMg576O5a656ZmiWjAKFOWNl-ihjOW-syDnvo7lrrkg6ZmiIhTljZfooYzlvrMg576O5a65IOmZoioCCAOSAQpoYWlyX3NhbG9uqgESEAEqDiIK576O5a65IOmZoigI&ved=2ahUKEwjlnv3S4_7uAhWKHHAKHQgwCu0QvS4wAnoECAIQQQ&rlst=f#lrd=0x601887db5d7a5e6d:0x9fac66b09bd2350f,1,,,&rlfi=hd:;si:11505684056739296527,l,ChPljZfooYzlvrMg576O5a656ZmiWjAKFOWNl-ihjOW-syDnvo7lrrkg6ZmiIhTljZfooYzlvrMg576O5a65IOmZoioCCAOSAQpoYWlyX3NhbG9uqgESEAEqDiIK576O5a65IOmZoigI;mv:[[35.674233199999996,139.9075969],[35.6647782,139.8983212]];tbs:lrf:!1m4!1u3!2m2!3m1!1e1!1m4!1u2!2m2!2m1!1e1!2m1!1e2!2m1!1e3,lf:1,lf_ui:2')
sleep 3

# binding.pry

#口コミページが表示されるまで待つ
wait.until { d.find_element(:class_name, 'lcorif').displayed? }

#JavaScriptで書くと↓
# document.getElementsByClassName("PuaHbe")[3].getElementsByClassName("Fam1ne")[0].getAttribute('aria-label')
# "5 点中 4.0 点の評価、"が返ってくる
star = d.find_elements(:class_name,"PuaHbe")[3].find_elements(:class_name,"Fam1ne")[0].attribute('aria-label')
# filter_star = star.scan(/\d+/)[1].to_i
#星の点数部分のみ小数点以下含めて取得
filter_star = star.scan(/\d+\.\d+?/)[0].to_f

p star
p filter_star