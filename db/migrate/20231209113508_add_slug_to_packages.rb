class AddSlugToPackages < ActiveRecord::Migration[7.1]
  def change
    add_column :packages, :slug, :string
  end
end
