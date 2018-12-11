class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :avatar
      t.references :user, index: true

      t.timestamps
    end
  end
end
