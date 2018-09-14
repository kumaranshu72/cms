class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :room_id
      t.datetime :from
      t.datetime :to
      t.string :status

      t.timestamps
    end
  end
end
