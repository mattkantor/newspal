class Item < ApplicationRecord
    validates_uniqueness_of :title, :scope=>:source_id
    belongs_to :source

    def find_topics
    
    end

end
