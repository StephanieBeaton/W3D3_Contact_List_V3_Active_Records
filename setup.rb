require 'pry' # in case you want to use binding.pry
require 'active_record'
require_relative 'lib/contact'
require_relative 'lib/phone'

# Output messages from Active Record to standard out
# ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'contact_list_v3',
  username: 'development',
  password: 'development',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)
puts 'CONNECTED'

puts 'Setting up Database (recreating tables) ...'

#   contacts
#
#  id |   firstname   | lastname  |         email
# ----+---------------+-----------+-----------------------
#   2 | Sam           | Jones     | samjones@test.com
#   3 | Sam           | Smith     | samsmith@test.com



#   phones
#
#  id |   digit    | type | contact_id
# ----+------------+------+------------
#   1 | 6041112222 | cell |          1
#   2 | 6049993333 | cell |          1


ActiveRecord::Schema.define do
  drop_table :contacts if ActiveRecord::Base.connection.table_exists?(:contacts)
  drop_table :phones   if ActiveRecord::Base.connection.table_exists?(:phones)
  create_table :contacts do |t|
    t.column :firstname, :string
    t.column :lastname, :string
    t.column :email, :string
    t.timestamps null: false
  end
  create_table :phones do |t|
    t.references :contact
    t.column :digit, :string
    t.column :ph_type, :string
    t.timestamps null: false
  end
end

# ================================================================
#
#  insert a contact and its phone numbers into the database
#
# ================================================================
def insert_contact(first_name, last_name, email, phone_numbers)
  contact = Contact.create(firstname: first_name, lastname: last_name, email: email)
  if !contact.id
    contact.errors.messages.each do |key, value|
       puts "#{key} #{value[0]}"
    end
  end

  phone_numbers.each do |phone_number|
    phone = contact.phones.create(digit: phone_number, ph_type: 'cell')

    if !phone.id
      phone.errors.messages.each do |key, value|
         puts "#{key} #{value[0]}"
      end
    end

  end
end


# insert 3 contacts and 3 phone numbers for those contacts
phone_numbers = []
first_name    = "Daffy"
last_name     = "Duck"
email         = "daffy@test.com"
phone_number  = "6043334444"
phone_numbers << phone_number

insert_contact(first_name, last_name, email, phone_numbers)

phone_numbers = []
first_name    = "Elmer"
last_name     = "Fudd"
email         = "elmer@test.com"
phone_number  = "6045557777"
phone_numbers << phone_number

insert_contact(first_name, last_name, email, phone_numbers)

phone_numbers = []
first_name    = "Mickey"
last_name     = "Mouse"
email         = "micker@test.com"
phone_number  = "7141112222"
phone_numbers << phone_number

insert_contact(first_name, last_name, email, phone_numbers)

puts 'Setup DONE'
