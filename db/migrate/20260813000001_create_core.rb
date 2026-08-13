class CreateCore < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :ics_url
      t.timestamps
    end

    create_table :settings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :grace_minutes, null: false, default: 2
      t.integer :lead_minutes
      t.boolean :confirm_nudge, null: false, default: false
      t.integer :escalate_after_seconds, null: false, default: 90
      t.json :channels, null: false, default: %w[imessage whatsapp call email]
      t.timestamps
    end

    create_table :meetings do |t|
      t.references :user, null: false, foreign_key: true
      t.string :uid
      t.string :title
      t.datetime :starts_at
      t.string :join_url
      t.string :provider
      t.boolean :hosting, null: false, default: false
      t.string :token
      t.datetime :acknowledged_at
      t.datetime :notified_at
      t.timestamps
      t.index :token, unique: true
      t.index %i[user_id uid], unique: true
    end
  end
end
