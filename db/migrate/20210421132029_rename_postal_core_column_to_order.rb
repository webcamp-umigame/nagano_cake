class RenamePostalCoreColumnToOrder < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :postal_core, :postal_code
  end
end
