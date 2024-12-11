class AddVisibilityToPhotos < ActiveRecord::Migration[8.1]
  def change
    add_column :photos, :visibility, :boolean, default: false
  end
end
