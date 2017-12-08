class Blog < ApplicationRecord
    has_many :entries, :dependent => :destroy
    validates :title, presence: true
end
