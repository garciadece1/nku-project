class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.integer :size
      t.integer :views
      t.boolean :private
      t.references :user, index: true

      t.timestamps
    end
  end
end
