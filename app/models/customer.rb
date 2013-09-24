class Customer < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :family_name, :given_name, :family_name_kana, :given_name_kana
  validates :family_name, :given_name, :family_name_kana, :given_name_kana, presence: true, length: { maximum: 40 }
end
