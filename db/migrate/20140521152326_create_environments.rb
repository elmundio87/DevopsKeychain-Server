class CreateEnvironments < ActiveRecord::Migration
  def change
    create_table :environments do |t|
      t.string :name
      t.text :public_key

      t.timestamps
    end

    remove_column :users, :pub_key

  end
end
