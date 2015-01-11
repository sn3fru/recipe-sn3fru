class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :Name
      t.date :Birthiday
      t.string :Occupation
      t.references :user, index: true

      t.timestamps
    end
  end
end
