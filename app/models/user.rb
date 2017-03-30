class User < ApplicationRecord

  validates :username, uniqueness: true,
                   length: { in: 3..30 }

  has_secure_password

end
