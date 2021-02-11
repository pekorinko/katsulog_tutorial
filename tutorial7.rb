#スクロールの部分だけ取り出したプログラム
#参考　https://rooter.jp/web-crawling/selenium-scrawl-slowly/

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