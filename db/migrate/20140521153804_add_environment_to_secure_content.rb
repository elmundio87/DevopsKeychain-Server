class AddEnvironmentToSecureContent < ActiveRecord::Migration
  def change
  	 add_column :secure_contents, :environment, :integer, null: false
  end
end
