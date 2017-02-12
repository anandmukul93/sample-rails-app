class AddForeignKeyToNumbers < ActiveRecord::Migration[5.0]
	def change
		add_column :phonebook_numbers, :contact_person_id, :number
	end
end
