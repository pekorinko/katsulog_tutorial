class Review
    #口コミの文章部分を @review_text に代入する
    def initialize(text, count)
        @text = text
        @count = count
    end
    #@review_text に代入された口コミの文章部分を返す
    def text
        @text
    end
    def count
        @count
    end

end

content = "良かった"
# local_guide = "ローカルガイド · 26 件のレビュー · 32 枚の写真".match(/ローカルガイド · /)
# p local_guide.post_match
local_guide = "ローカルガイド · 26 件のレビュー · 32 枚の写真".match(/件のレビュー/)
p $`

review1 = Review.new(content,local_guide)
review2 = Review.new(content,local_guide)
review3 = Review.new(content,local_guide)

reviews = []
reviews.push(review1)
reviews.push(review2)
reviews.push(review3)


reviews.each do |review|
    puts review.count
    puts review.text
end