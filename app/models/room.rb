class Room < ActiveRecord::Base
    belongs_to :building
    has_many :review
    belongs_to :facility_type, foreign_key: 'facilitytype_id'
end
