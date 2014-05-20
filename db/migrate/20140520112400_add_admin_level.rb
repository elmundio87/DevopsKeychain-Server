class AddAdminLevel < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      ## Database authenticatable
      t.add_column :admin, :boolean, null: false, default: false
    end

  end

 def change
    add_column :users, :admin, :boolean, null: false, default: false
 end
end
