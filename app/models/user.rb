require "base64"
require 'bcrypt'

class User < ApplicationRecord
    include BCrypt
    # has_secure_password
    attr_accessor :password

    validates :email, presence: true,
        uniqueness: true,
        confirmation: { case_sensitive: false },
        length: { in: 8..32 }
    validates :email, format: {with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/}
    validates :password, confirmation: true
    validates :password, presence: true, format: { with: /(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}/}
    validates :password_confirmation, presence: true, on: :create

    has_many :tasks
    has_many :categories

    after_create :generate_token

    def password
        @password ||= BCrypt::Password.new(password_digest)
    end

    def generate_token
        self.token_expiration = Time.now + Rails.application.config.auth_token_expiration
        self.token = Base64.encode64(self.token_expiration.to_s + self.email)[0..32]
        self.save
    end
    
    def authenticate(signin_params)
        if self.password == signin_params[:password]
            return true
        else
            errors.add(:base, "Invalid credentials")
            return false
        end
    # else
    #     return 'Invalid email and password'
    # end
    end

    def verify_password(signup_params)
        if signup_params[:password] == signup_params[:password_confirmation]
            self.password_digest = BCrypt::Password.create(signup_params[:password])
        end
    end

    def token_expired?
        if self.token_expiration == nil || self.token_expiration < Time.now
            return true
        else
            return false
        end
    end
end