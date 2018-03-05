class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.string :token
      t.string :loginTicketURL
      t.timestamps
    end
  end
end
