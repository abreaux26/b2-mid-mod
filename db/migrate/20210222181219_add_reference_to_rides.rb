class AddReferenceToRides < ActiveRecord::Migration[5.2]
  def change
    add_reference :rides, :amusement_park, foreign_key: true
    change_column_default :rides, :amusement_park_id, 0
  end
end
