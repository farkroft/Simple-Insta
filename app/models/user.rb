class User < ApplicationRecord
    has_many :pictures, dependent: :destroy
end
