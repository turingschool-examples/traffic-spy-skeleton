class CreateRefers < ActiveRecord::Migration
  def change
    create_table :refers do |t|
      t.string   :address

      t.timestamps null: false
    end
  end
end