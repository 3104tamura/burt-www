class CreateTrainers < ActiveRecord::Migration[5.1]
  def change
    create_table :trainers do |t|
      ## Database authenticatable
      t.string :name, null: false, default: ''
      t.integer :age
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :cover
      t.text :profile
      t.text :licence_and_award_received
      t.text :comment_to_users

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.string :nickname, default: ""
      t.integer :gender, default: 1
      t.string :provider
      t.string :uid
      t.string :last_name
      t.string :first_name
      t.string :image

      t.timestamps null: false
    end


    add_index :trainers, :email,                unique: true
    add_index :trainers, :reset_password_token, unique: true
    # add_index :trainers, :confirmation_token,   unique: true
    # add_index :trainers, :unlock_token,         unique: true
  end
end
