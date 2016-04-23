class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :display_name
      t.string :created_at
      t.string :updated_at
      t.string :last_game_played
      t.string :last_stream_title
      t.string :logo
      t.integer :total_views
      t.integer :follower_count
      t.integer :following_count
      t.boolean :partner_boolean
      t.string :timestamp
    end
  end
end
