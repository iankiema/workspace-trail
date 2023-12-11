class AddLocationToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :location, :string
  end
end
