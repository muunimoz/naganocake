class Address < ApplicationRecord
  belongs_to :customer

  validates :postal_code, presence: true
  validates :destination, presence: true
  validates :name, presence: true
  
  def finally_address
    '〒' + postal_code + ' ' + destination + ' ' + name
  end

end
