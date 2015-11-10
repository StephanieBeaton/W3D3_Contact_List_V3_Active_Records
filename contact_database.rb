## TODO: Implement CSV reading/writing
require 'csv'

class ContactDatabase

  @@file_name = 'contacts.csv'

  # =====================================================
  #
  #   load the database into memory
  #
  # =====================================================
  def self.load_database
    @@contacts_array = CSV.read(@@file_name, col_sep: ',', converters: :numeric)

    # puts "inside ContactDatabase.load_database"
    # puts "@@contacts_array"
    # puts @@contacts_array
  end


  # =====================================================
  #
  #   Write the whole database to a file
  #
  # =====================================================
  def self.write_database_to_file


    # puts "inside ContactDatabase.write_database_to_file"
    # puts "@@contacts_array"
    # puts @@contacts_array

    CSV.open(@@file_name, 'w') do |csv_object|
      @@contacts_array.each do |row_array|
        csv_object << row_array
      end
    end
  end

  # =====================================================
  #
  #   Find next unique Contact Id
  #
  # =====================================================
  def self.get_next_contact_id
    # iterate thru @@contacts_array to find max id
    result_id = @@contacts_array.reduce(0) do |max_id, contact|
      contact[0].to_i > max_id ? contact[0].to_i : max_id
    end
    # return max id + 1
    result_id += 1
  end

  # =====================================================
  #
  #   Write a Contact to the database
  #
  # =====================================================
  def self.write_new_row_to_file(contacts_to_add)
    #  puts "inside ContactDatabase.write_new_row_to_file"


    # add id field to front of row here
    next_id = ContactDatabase.get_next_contact_id
    # puts "next_id = #{next_id}"

    contacts_to_add[0].unshift(next_id.to_s)

    CSV.open(@@file_name, 'a') do |csv_object|
      contacts_to_add.each do |row_array|
        csv_object << row_array
      end
    end

    @@contacts_array << contacts_to_add[0]

    # puts ""
    # puts "@@contacts_array"
    # puts @@contacts_array

    return


  end

  # =====================================================
  #
  #   List all Contacts in the database
  #
  # =====================================================
  def self.list

    # Example output
    # 12: Khurram Virani (kvirani@lighthouselabs.ca)
    # 14: Don Burks (don@lighthouselabs.ca)
    # ---
    # 2 records total

    total = 0
    @@contacts_array.each do |contact|
      puts "#{contact[0]}: #{contact[1]} (#{contact[2]}) #{contact[3]}"
      total += 1
    end
    puts "#{total} records total"
  end

  # =====================================================
  #
  #   Show Contact details
  #
  # =====================================================
  def self.show
    # When on the user sends in the show command
    # along with an id (index) of the contact,
    # the app should display their details.
    # If a contact with that index/id is found,
    # display their details,
    # with each field being printed on an individual line.

    # If the contact cannot be found,
    # display a custom "not found" message.

    puts "Enter contact id:"
    contact_id = STDIN.gets.chomp

    found_contact = nil

    # iterate thru the @@contacts_array and find contact with contact_id
    @@contacts_array.each do |contact|
      # puts "contact ="
      # puts contact
      found_contact = contact if contact_id.to_i == contact[0].to_i
    end

    if found_contact
      puts ""
      puts "contact id: #{found_contact[0]}"
      puts "full name: #{found_contact[1]}"
      puts "email: #{found_contact[2]}"
      puts "phone numbers: #{found_contact[3]}"
    else
      puts "not found"
    end

  end

  # =====================================================
  #
  #   Find contact with names and email addresses
  #   ... containing passed in string
  #
  # =====================================================
  def self.find(search_term)

    # puts ""
    # puts "inside ContactsDatabase.find"

    # puts ""
    # puts "search_term = #{search_term}"

    @@contacts_array.each do |contact|
      search_result = nil

      # puts "contact = "
      # puts contact

      # search full name for sub string
      search_result = contact[1].match(search_term)
      # puts "first search_result = "
      # puts search_result.inspect


      if !search_result
        # puts ""
        # search email for sub string
        search_result = contact[2].match(search_term)
        # puts "second search_result = "
        # puts search_result.inspect
      end

      if search_result
        puts "#{contact[0]}: #{contact[1]} (#{contact[2]})  #{contact[3]}"
      end

    end
  end

  # =====================================================
  #
  #   Test if duplicate email address in database
  #
  # =====================================================
  def self.duplicate?(email)

    # puts ""
    # puts "inside ContactsDatabase.duplicate? "

    # puts "email = #{email}"

    @@contacts_array.each do |contact|
      search_result = nil

      # puts "contact = "
      # puts contact

      # search email for sub string
      search_result = contact[2].match(email)
      # puts "first search_result = "
      # puts search_result.inspect

      return true if search_result

    end

    # puts "returning false"

    false

  end

end
