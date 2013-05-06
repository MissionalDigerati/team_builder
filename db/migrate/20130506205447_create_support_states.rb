class CreateSupportStates < ActiveRecord::Migration
  def change
    create_table :support_states do |t|
      t.integer :contact_id
      t.boolean :initial, default: true
      t.boolean :letter_sent, default: false
      t.date :letter_sent_on
      t.boolean :contacting, default: false
      t.boolean :seen_presentation, default: false
      t.date :presented_on
      t.boolean :following_up, default: false
      t.date :responding_on
      t.boolean :one_time_gift, default: false
      t.boolean :monthly_gift, default: false
      t.boolean :not_giving, default: false
      t.boolean :no_response, default: false
      t.timestamps
    end
  end
end
