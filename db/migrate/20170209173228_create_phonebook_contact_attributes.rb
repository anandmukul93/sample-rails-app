class CreatePhonebookContactAttributes < ActiveRecord::Migration[5.0]
  def change
    create_table :phonebook_contact_attributes do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
