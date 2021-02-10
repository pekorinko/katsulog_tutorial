require 'selenium-webdriver'

d = Selenium::WebDriver.for :chrome

#↓口コミページが意図したように表示される美容院
#d.get('https://www.google.com/search?q=%E3%82%A2%E3%83%B3%E3%82%A2%E3%83%9F+%E5%90%89%E7%A5%A5%E5%AF%BA&rlz=1C5CHFA_enJP939JP939&oq=Unami+&aqs=chrome.5.69i57j0l4j0i10l3j0i4l2.4196j0j4&sourceid=chrome&ie=UTF-8#lrd=0x6018ef4af276881d:0x515b56a02750a38d,1,,,')

#↓口コミページが表示されない（口コミのURLなのに店舗情報がまとまっているページしか表示されない）
d.get('https://www.google.com/search?q=lino%20by%20u-realm%20%E5%90%89%E7%A5%A5%E5%AF%BA&rlz=1C5CHFA_enJP939JP939&oq=Lino&aqs=chrome.0.69i59j69i57j0j0i4l3j0l2j0i4j0.4197j0j9&sourceid=chrome&ie=UTF-8&tbs=lf:1,lf_ui:2&tbm=lcl&sxsrf=ALeKk03S05r887nYoT7ZJ4fmVI9NHW3Hbw:1612878020560&rflfq=1&num=10&rldimm=5116101236115509091&lqi=ChlsaW5vIGJ5IHUtcmVhbG0g5ZCJ56Wl5a-6SPn485HCq4CACFo-ChlsaW5vIGJ5IHUgcmVhbG0g5ZCJ56Wl5a-6IhlsaW5vIGJ5IHUgcmVhbG0g5ZCJ56Wl5a-6KgYIAhAAEAFiCwmV4GDbAtIqbRACYgsJXKAnTeGfdHMQAmILCc91RTq4nuNKEAJiCwnspGKthxa_aRACYgsJ-rvwveDPClwQApIBEnVuaXNleF9oYWlyZHJlc3Nlcg&ved=2ahUKEwiawuzr9tzuAhVIFqYKHVvKA7UQvS4wAXoECAUQHA&rlst=f#lrd=0x6018ee4c79631831:0x47000af7cd9a0f63,1,,,&rlfi=hd:;si:5116101236115509091,l,ChlsaW5vIGJ5IHUtcmVhbG0g5ZCJ56Wl5a-6SPn485HCq4CACFo-ChlsaW5vIGJ5IHUgcmVhbG0g5ZCJ56Wl5a-6IhlsaW5vIGJ5IHUgcmVhbG0g5ZCJ56Wl5a-6KgYIAhAAEAFiCwmV4GDbAtIqbRACYgsJXKAnTeGfdHMQAmILCc91RTq4nuNKEAJiCwnspGKthxa_aRACYgsJ-rvwveDPClwQApIBEnVuaXNleF9oYWlyZHJlc3Nlcg;mv:[[35.7028058,139.5768803],[35.701809499999996,139.5764925]];tbs:lrf:!1m4!1u2!2m2!2m1!1e1!2m1!1e2!3sIAE,lf:1,lf_ui:2')

sleep 3