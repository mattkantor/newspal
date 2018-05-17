class Item < ApplicationRecord
    validates_uniqueness_of :title, :scope=>:source_id
    belongs_to :source
    has_many :entities

    def find_topics

    end

    before_save :sentiment_anal, :clean_body #, :get_ner

    def clean_body
      self.body = ApplicationController.helpers.sanitize(self.body, :tags=>[])
    end

    def get_ner
        sentence = self.title
        pyscript_path = Rails.root.join('python/main.py')
        entities_json = `python3 #{pyscript_path} "#{sentence}"`.chomp
        puts entities_json
        hash = JSON.parse(entities_json)
        puts hash

        #self.entities << entities.collect!{|e| Entity.new(name:e).first_or_create!}

    end

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
