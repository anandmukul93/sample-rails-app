class User < ApplicationRecord
    before_save { self.email.downcase! }

    VALID_EMAIL_REGEX = /\A((\w+\d*)|(\d+\w*))([\.\-\_\+][\w\d]+)*((\_)|([\_\.\-\+][\w\d]+))?@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

    validates :name, presence:true, length: { maximum: 50 }
    validates :email, presence:true, length:{ maximum: 250 }, format: {with:VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
end