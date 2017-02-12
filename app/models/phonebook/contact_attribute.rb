class Phonebook::ContactAttribute < ApplicationRecord
	belongs_to :contact_person
	validates :key, presence: true, length: {minimum: 3, maximum: 30}
	validates :value, presence: true, length: {maximum: 100}
end