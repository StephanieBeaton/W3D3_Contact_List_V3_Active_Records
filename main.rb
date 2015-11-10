


# Creating a new record
contact = Contact.new("Khurram", "Virani", "kv@example.com")
contact.save



Updating a record

contact.firstname = "K"
contact.lastname = "V"

# Since this contact was already created,
# the save method will know not to INSERT this contact
# but rather UPDATE it in the database:
contact.save


# Loading a record by id

# same_contact = Contact.find(5)
# puts same_contact.firstname
# puts same_contact.lastname
# puts same_contact.email

# show action in the REPL.
# When a user asks to see contact #5,
# our Application can use the Contact.find
# to retrieve the contact!


contacts = Contact.find_all_by_lastname('Virani')
contacts.each do |c|
  puts c
end


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


