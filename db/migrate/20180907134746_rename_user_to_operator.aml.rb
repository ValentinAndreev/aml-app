# This migration comes from aml (originally 20180831065637)
class RenameUserToOperator < ActiveRecord::Migration[5.2]
  def change
    rename_table :aml_users, :aml_operators
    rename_column :aml_orders, :user_id, :operator_id
  end
end
