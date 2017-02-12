class CreatePhonebookContactPeople < ActiveRecord::Migration[5.0]
  def change
    create_table :phonebook_contact_people do |t|
      t.string :name
      t.timestamps
    end
  end
end
