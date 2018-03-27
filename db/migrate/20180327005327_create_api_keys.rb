class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys, id: :uuid do |t|
      t.references :user, foreign_key: true
      t.string :status
    end
  end
end
