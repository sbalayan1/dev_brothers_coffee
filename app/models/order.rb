class Order < ApplicationRecord
    belongs_to :user
    belongs_to :cart
    # belongs_to :drink
    # belongs_to :bean
end

