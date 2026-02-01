class User < ApplicationRecord
    has_many :tickets, dependent: :destroy
    
    validates :name, presence: true, length: { minimum: 2, maximum: 50 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 30 }
    validates :role, presence: true, inclusion: { in: %w[admin support user] }
    
    has_secure_password
    validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }
end
