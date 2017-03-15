class User < ApplicationRecord

  validates :name, uniqueness: true,
                   length: { in: 3..30 }

end
