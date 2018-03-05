class CreateBooths < ActiveRecord::Migration[5.1]
  def change
    create_table :booths do |t|
      t.timestamps
    end
  end
end
