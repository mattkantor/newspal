class Item < ApplicationRecord
    validates_uniqueness_of :title, :scope=>:source_id
    belongs_to :source

    def find_topics

    end

    before_save :sentiment_anal

    def sentiment_anal
      analyzer = Sentimental.new
      analyzer.load_defaults
      if self.body and self.body!=""
        score = analyzer.score self.body
      else
        score = analyzer.score self.title
      end
      self.sentiment = score
    end

end
