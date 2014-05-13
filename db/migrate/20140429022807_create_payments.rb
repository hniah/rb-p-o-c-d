class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :ip_address
      t.string :express_token
      t.string :express_payer_id
      t.references :user
      t.references :package
      t.string :status, default: :pending
      t.timestamps
    end
  end
end
