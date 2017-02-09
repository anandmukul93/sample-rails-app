class CreatePhonebookNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :phonebook_numbers do |t|
      t.string :number
      t.string :countrycode

      t.timestamps
    end
  end
end
