class Search < ApplicationRecord
  belongs_to :title, optional: true
  belongs_to :author, optional: true
end
