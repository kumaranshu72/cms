class CreateFactilities < ActiveRecord::Migration[5.2]
  def change
    create_table :factilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
