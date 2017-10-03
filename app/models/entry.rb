class Entry < ApplicationRecord
    has_many :comments
    belongs_to :blog
end
