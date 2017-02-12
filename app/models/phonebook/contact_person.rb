class Phonebook::ContactPerson < ApplicationRecord

	has_many :numbers, :contact_attributes
	validates :name, presence: true, length: {maximum: 50}
	accepts_nested_attributes_for :numbers, allow_destroy: true
	filterrific(
		default_filter_params: { sorted_by: 'created_at_desc' },
		available_filters: [
			:search_name
		]
	)

	scope :search_name, lambda { |name_substring|
		where("name LIKE ?", name_substring)
	}

	# scope :search_number, lambda { |number_substring|
	# 	where ("number LIKE ?", number_substring)
	# }
end