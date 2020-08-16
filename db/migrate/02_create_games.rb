class CreateGames < ActiveRecord::Migration[5.1]

  def change 
    create_table :games do |t|
      t.string :name
      t.string :platform
      t.integer :user_id
    end 
  end 

end 