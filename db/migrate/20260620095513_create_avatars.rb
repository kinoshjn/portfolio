class CreateAvatars < ActiveRecord::Migration[7.2]
  def change
    create_table :avatars do |t|
      t.string :image_path,null: false
      t.integer    :required_login_count,null: false

      t.timestamps
    end
  end
end
