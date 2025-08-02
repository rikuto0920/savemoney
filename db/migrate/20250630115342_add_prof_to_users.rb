class AddProfToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :prof, :string
  end
end
