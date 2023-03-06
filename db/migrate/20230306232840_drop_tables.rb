class DropTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :pay_customers
    drop_table :pay_charges
    drop_table :pay_merchants
    drop_table :pay_payment_methods
    drop_table :pay_subscriptions
    drop_table :pay_webhooks
  end
end
