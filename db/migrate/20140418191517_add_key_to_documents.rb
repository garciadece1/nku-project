class AddKeyToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :key, :string
  end
end
