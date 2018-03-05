class CreateWebinars < ActiveRecord::Migration[5.1]
  def change
    create_table :webinars do |t|
      t.string :title
      t.string :url
      t.string :favicon
      t.string :date
      t.timestamps
    end
  end
end
