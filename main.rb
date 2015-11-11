require_relative 'contact'
require_relative 'phone'
require 'pg'
require 'pry'



# Creating a new record
# contact = Contact.new("Khurram", "Virani", "kv@example.com")
# contact.save





# Loading a record by id

# same_contact = Contact.find(5)
# puts same_contact.firstname
# puts same_contact.lastname
# puts same_contact.email

# show action in the REPL.
# When a user asks to see contact #5,
# our Application can use the Contact.find
# to retrieve the contact!


# Updating a record

# same_contact.firstname = "K"
# same_contact.lastname = "V"

# Since this contact was already created,
# the save method will know not to INSERT this contact
# but rather UPDATE it in the database:
# same_contact.save

# contacts = []
# contacts = Contact.find_all_by_lastname('Smith')
# contacts.each do |c|
#   p c
# end

# contacts = []
# contacts = Contact.find_all_by_firstname('Jim')
# contacts.each do |c|
#   p c
# end

# DELETE that contact row from the contacts table:
# same_contact.destroy

# same_contact will no longer point to a valid,
# existing record in the database,
# using ORM methods like save and destroy (again)
#  will likely cause a postgres error/exception.
# That's okay for now.
# (We can prevent this by throwing our own exception to the caller
# instead of attempting to execute an invalid query
# but let's leave that for now.)


# same_contact.find(5)    #  => returns nil

# ========================================================

#  Phones


# Creating a new record
same_phone = Phone.new("6041234567", "cell", 1)
same_phone.save

same_phone = Phone.find(3)
puts same_phone.digit
puts same_phone.ph_type
# puts same_phone.contact

# Updating a record

same_phone.digit = "7777777777"

# Since this phone was already created,
# the save method will know not to INSERT this phone
# but rather UPDATE it in the database:
same_phone.save

same_phone.destroy

