class AddSubscribeToMailingListToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_to_mailing_list, :boolean, default: false
  end
end
