class CreateSecureContents < ActiveRecord::Migration
  def change
    create_table :secure_contents do |t|
      t.string :name
      t.string :content
      t.integer :owner
      t.timestamps
    end
  end
end
