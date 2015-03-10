class Pack < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  def current?
    id == user.current_pack_id
  end
end
