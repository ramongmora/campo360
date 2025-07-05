class Supplier < ApplicationRecord
  has_many :transactions, as: :transactionable

  def display_name
    name
  end
end
