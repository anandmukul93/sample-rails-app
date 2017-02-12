class Phonebook::ContactsController < ApplicationController
	layout "phonebook"

    def search
		contact_field = params && params[:contact]&& params[:contact][:input]
		@filterrific = Filterrific.new(Contact, contact_field)
		@filterrific.select_options = {
			search_query: contact_field
		}
    end

    def add
    end

end
