class CreateUserSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :user_sessions do |t|
      t.string :ip

      t.timestamps
    end
  end
end
