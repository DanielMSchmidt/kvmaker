class CreateKvs < ActiveRecord::Migration
  def change
    create_table :kvs do |t|
      t.string :fields
      t.string :values

      t.timestamps
    end
  end
end
