class CreateRoomFacilities < ActiveRecord::Migration[5.2]
  def change
    create_table :room_facilities do |t|
      t.integer :room_id
      t.integer :facility_id

      t.timestamps
    end
  end
end
