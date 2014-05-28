class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :punctuality
      t.string :communication
      t.string :time_management
      t.string :service_quality
      t.string :areas_for_improvement
      t.string :areas_worthy_of_praise
      t.string :other_comments

      t.timestamps

      t.references :user, index: true
      t.references :housekeeper, index: true
      t.references :time_slot, index: true
    end
  end
end
