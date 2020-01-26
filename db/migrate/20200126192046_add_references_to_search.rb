class AddReferencesToSearch < ActiveRecord::Migration[5.2]
  def change
    add_reference :searches, :title
    add_reference :searches, :author
  end
end
