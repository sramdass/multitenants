class CreateTenants < ActiveRecord::Migration
  def change
    create_table :tenants do |t|
      t.string :userid
      t.string :subdomain
      t.string :db_password

      t.timestamps
    end
  end
end
