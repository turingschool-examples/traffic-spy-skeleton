class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.text :request_hash
    end
  end
end
