class Patient < ActiveRecord::Base
  belongs_to :location
end
