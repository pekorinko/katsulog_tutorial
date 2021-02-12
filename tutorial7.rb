#スクロールの部分だけ取り出したプログラム
#参考　https://rooter.jp/web-crawling/selenium-scrawl-slowly/

require 'selenium-webdriver'

d = Selenium::WebDriver.for :chrome

wait = Selenium::WebDriver::Wait.new(:timeout => 100)

d.get('https://www.google.com/search?q=%E3%82%A2%E3%83%B3%E3%82%A2%E3%83%9F+%E5%90%89%E7%A5%A5%E5%AF%BA&rlz=1C5CHFA_enJP939JP939&oq=Unami+&aqs=chrome.5.69i57j0l4j0i10l3j0i4l2.4196j0j4&sourceid=chrome&ie=UTF-8#lrd=0x6018ef4af276881d:0x515b56a02750a38d,1,,,')

wait.until  {d.find_element(:xpath, '//*[@id="reviewSort"]/div/div[2]/div[2]/div[1]/div[3]/div[2]/span').displayed?}

#初期のページの高さを取得する←document.body.scrollHeight が何を指しているのか調べる
before_height = d.execute_script("return document.body.scrollHeight")

while true
    #初期のページの高さを10分割して、1/10, 2/10, ..., 10/10の高さに移動するように1/10ずつ加算された高さは height に格納される
    1.step(before_height, before_height/10).each do |height|
        sleep 1
        #1/10高さが加算された位置までスクロールする
        d.execute_script("window.scrollTo(0, #{height})")
    end

    sleep 1

    #１０回スクロールが終わった時点での高さ
    after_height = d.execute_script("return document.body.scrollHeight")

    #before_height（初期のページの高さ）とafter_height（１０回スクロールし終わった時点でのページの高さが同じだったら）
    if after_height == before_height
        break
    end
end