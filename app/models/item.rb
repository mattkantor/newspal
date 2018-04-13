class Item < ApplicationRecord
    validates_uniqueness_of :title, :scope=>:source_id

end
