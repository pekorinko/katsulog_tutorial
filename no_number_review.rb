class Review
    #口コミの文章部分を @review_text に代入する
    def initialize(text, count, star)
        @text = text
        @count = count
        @star = star
    end
    #@review_text に代入された口コミの文章部分を返す
    def text
        @text
    end
    def count
        @count
    end
    def star
        @star
    end

end

content = "良かった"
#Rubyの文字列はStringクラスのインスタンス→Stringクラスにはmatchメソッドがある
#matchは配列のように扱える、26だけを取り出すためにキャプチャ()を使った
#正規表現試行錯誤の記録 https://discord.com/channels/790571394197880892/808679194003111956/812868078174076938
local_guide = ""
star_score = "4.0"
p local_guide



review1 = Review.new(content,local_guide,star_score)
review2 = Review.new(content,local_guide,star_score)
review3 = Review.new(content,local_guide,star_score)

reviews = []
reviews.push(review1)
reviews.push(review2)
reviews.push(review3)


reviews.each do |review|
    puts review.count
    puts review.text
    puts review.star
end