class CreateVerifications < ActiveRecord::Migration
  def change
    create_table :verifications do |t|
      t.references :user
      t.string :key

      t.timestamps
    end
  end
end
