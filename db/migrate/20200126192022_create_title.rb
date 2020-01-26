class CreateTitle < ActiveRecord::Migration[5.2]
  def change
    create_table :titles do |t|
      t.string :name
    end
  end
end
