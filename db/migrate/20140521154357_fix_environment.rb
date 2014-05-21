class FixEnvironment < ActiveRecord::Migration
  def change
  	 add_column :environments, :deployment, :integer, null: false
  end
end
