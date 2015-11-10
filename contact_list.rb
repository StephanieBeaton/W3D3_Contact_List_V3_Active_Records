require_relative 'contact'
require_relative 'contact_database'
# require 'csv'

# TODO: Implement command line interaction
# This should be the only file where you use puts and gets

# ========================================================================
# You will build a ruby command line application
# to help users manage their contacts
# through a Request-Response CLI interface.

# This means that you will be issuing commands like:

# ruby contact_list.rb show 1
# This would breakdown according to the following:

# ruby - Obviously, the ruby parser, same as you would use to run any Ruby script.
# contact_list.rb - The name of your script.
# show - The command you are going to issue to the Contact list app.
#        (Full list of commands below)
# 1 - The parameter being passed to that command.
#  (Tip: Not all commands will take parameters. Some will take multiple.)

# Reminders & Tips:

# Seed some fake data in so you don’t have to create contacts each time you restart the app

# ========================================================================

# Each contact will be represented by an instance of the Contact object.
#
# Similarly, the main application (responsible for user input and output)
# could be managed via an instance of Application.
#

# run bundle install to install the necessary gems for a given project.
# this uses "Gemfile" file

# run gem install bundler to install the latest version

# More on Bundler:

# http://ruby.about.com/od/bundler/ss/What-Is-Bundler.htm
# http://yehudakatz.com/2010/09/30/bundler-as-simple-as-what-you-did-before/

#
#
#   Command Line Arguments

# Arguments to a command can be accessed via the Argument Vector
# (ARGV, which is a constant because it starts with a capital letter).

# Make a new file (touch contacts.csv)
# that will hold all of your data.
# When the app starts, it will look for this file.
# If the file is there, it should load all the contacts from it into memory.
# In order to do this in an OOP way, you should introduce a ContactDatabase class
# that is responsible for reading and writing this file.

# Things to consider:
#   How many methods will this class have?
#   Should they be instance or class methods?
#   At what point(s) should the app write to the file?

class DuplicateEmailAddress < StandardError

end

ContactDatabase.load_database


command = ARGV[0]
case command
when "help"

  #    Task 1: Main menu and user input

  puts ""
  puts "Here is a list of available commands:"
  puts "  new  - Create a new contact"
  puts "  list - List all contacts"
  puts "  show - Show a contact"
  puts "  find - Find a contact"
  puts ""

when "new"
  puts "command is new"
  puts ""

  #   Task 2: Implement contact creation (new command)

  # ruby contact_list.rb new

  # further prompt the user for information about the contact they wish to create.
  #  Eg: take a full name and email (separately).\
  #  These should be added to an (initially empty) array of contacts.
  #  The full name and the email should be input as separate strings
  #  as they will need to be output as such.

  # Once a user has entered the data,
  # the app should store the contact into the CSV file
  # and return the ID of the new contact.


  # Task 6.  Prevent duplicate entries
  #
  # If a user tries to input the exact contact
  # with a the same email address twice,
  # the app should output an error saying that the contact already exists
  # and cannot be created.
  # If you are asking for name first and then email,
  # for a better user experience,
  # it may make more sense to ask for their email first and then their name.

  begin
    puts "Enter email:"
    email = STDIN.gets.chomp
    if ContactDatabase.duplicate?(email)
      # puts "about to raise DuplicateEmailAddress Exception"
      raise DuplicateEmailAddress
    end

    puts "Enter first name last name:"
    full_name = ""
    full_name = STDIN.gets.chomp


    phone_number = ""
    phone_numbers = ""

    begin
      puts "Enter a phone number or 'end' if no more phone numbers:"
      phone_number = ""
      phone_number = STDIN.gets.chomp

      if phone_number != "end"
        if phone_numbers == ""
          phone_numbers += phone_number
        else
          phone_numbers += "," + phone_number
        end
      end
    end until phone_number == "end"

    contacts_to_add = []

    contact = []

    contact << full_name
    contact << email
    contact << phone_numbers
    contacts_to_add << contact

    ContactDatabase.write_new_row_to_file(contacts_to_add)

rescue DuplicateEmailAddress
    puts "Email address #{email} is already in the ContactsDatabase"
  end


when "list"
  puts "command is list"

  #    Task 3: Implement Contact index (list command)

  # Example output
  # 12: Khurram Virani (kvirani@lighthouselabs.ca)
  # 14: Don Burks (don@lighthouselabs.ca)
  # ---
  # 2 records total

  ContactDatabase.list

when "show"
  puts "command is show"

  #  Task 4: Contact details (show command)

  # When on the user sends in the show command
  # along with an id (index) of the contact,
  # the app should display their details.
  # If a contact with that index/id is found,
  # display their details,
  # with each field being printed on an individual line.

  # If the contact cannot be found,
  # display a custom "not found" message.


  ContactDatabase.show

when "find"
  puts "command is find"

  #    Task 5: Implement Contact search (find command)

  # After issuing the find command,
  # along with a search term,
  # the app will search through the names of the contacts
  # and print the contact details
  # of any contacts which have the search term contained within their name
  # or email.
  # (ie. the search term is a substring of the contact’s email or name)

  #  Example use:

  #  ruby contact_list.rb find ted

  ContactDatabase.find(ARGV[1])

else
  puts "You gave me #{command} -- I have no idea what to do with that."
end







