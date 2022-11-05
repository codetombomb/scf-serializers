class User < ApplicationRecord
    has_many :purchased_items, class_name: "Item", foreign_key: 'buyer_id', dependent: :destroy
    has_many :sold_items, class_name: "Item", foreign_key: 'seller_id', dependent: :nullify
    
    validates :username, presence: true, uniqueness: true 
    validates :email, format: /\w+@\w+\.{1}[a-zA-Z]{2,}/, presence: true, uniqueness: true
end
