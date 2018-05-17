class Item < ApplicationRecord
    validates_uniqueness_of :title, :scope=>:source_id
    belongs_to :source
    has_many :entities

    def find_topics

    end

    before_save :sentiment_anal, :clean_body , :get_ner

    def clean_body
      self.body = ApplicationController.helpers.sanitize(self.body, :tags=>[])
    end

    def get_ner
        sentence = self.title
        pyscript_path = Rails.root.join('python/main.py')
        entities_json = `python3 #{pyscript_path} "#{sentence}"`.chomp
        hash = JSON.parse(entities_json)
        hash.each do |ent|
          type = ent["type"]
          name = ent["text"]
          Entity.where(name:name,  pos:type, item_id:self.id).first_or_create
        end

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
