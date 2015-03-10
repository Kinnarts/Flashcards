class User < ActiveRecord::Base
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end
  has_many :cards
  has_many :authentications, dependent: :destroy
  has_many :packs
  belongs_to :current_pack, class_name: "Pack"
  accepts_nested_attributes_for :authentications

  validates :password, length: { minimum: 3 }, on: [:create, :update]
  validates :password, confirmation: true, on: [:create, :update]
  validates :password_confirmation, presence: true, on: [:create, :update]
  validates :email, uniqueness: true, presence: true

  def set_current_pack(id)
    update_column(:current_pack_id, id)
  end
end
