class AddFieldsToHousekeepers < ActiveRecord::Migration
  def change
    add_column(:housekeepers, :created_at, :datetime)
    add_column(:housekeepers, :updated_at, :datetime)
    add_column(:housekeepers, :experience_level , :string)
    add_column(:housekeepers, :secondary_contact, :string)
    add_column(:housekeepers, :language_spoken, :string)
    add_column(:housekeepers, :special_remarks, :text)
  end
end
