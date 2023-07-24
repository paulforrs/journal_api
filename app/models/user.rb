require "base64"
require 'bcrypt'

class User < ApplicationRecord
    include BCrypt
    # has_secure_password
    attr_accessor :password
    validates :email, presence: true, uniqueness: true
    validates :password, confirmation: true
    validates :password, presence: true
    validates :password_confirmation, presence: true, on: :create

    has_many :tasks
    has_many :categories, -> { distinct}, through: :tasks

    after_create :generate_token

    def password
        @password ||= Password.new(password_digest)
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
        if self.token_expiration == nil
            if self.token_expiration < Time.now
                return true
            end
        end
    end
end