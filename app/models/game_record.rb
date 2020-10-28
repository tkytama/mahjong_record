class GameRecord < ApplicationRecord
  belongs_to :user
  belongs_to :room




  scope :created_after, -> (time) {
    time = time.to_time
    where('created_at > ?', time)
  }
  scope :created_before, -> (time) {
    time = time.to_time
    where('created_before > ?', time)
  }

  class << self
    def ransackable_scopes(auth_object = nil)
      [:created_after, :created_before]
    end
  end


end
