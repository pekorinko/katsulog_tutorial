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
review1 = Review.new(content,1)
review2 = Review.new(content,2)
review3 = Review.new(content,3)

reviews = []
reviews.push(review1)
reviews.push(review2)
reviews.push(review3)


reviews.each do |review|
    puts review.count
end