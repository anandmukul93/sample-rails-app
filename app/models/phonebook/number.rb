class Phonebook::Number < ApplicationRecord
	VALID_PHONE_NO_PATTERN = /[0-9][0, -9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]/
	belongs_to :contact_person, foreign_key:
	validates :number, length: {minimum:10, maximum:10}, presence: true, uniqueness: true, format: {with: VALID_PHONE_NO_PATTERN}
end
