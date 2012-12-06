class AddInputToKv < ActiveRecord::Migration
  def change
    add_column :kvs, :input, :integer
  end
end
