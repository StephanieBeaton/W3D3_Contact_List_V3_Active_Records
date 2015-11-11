
class Contact

  attr_accessor :firstname, :lastname, :email, :phones
  attr_reader   :id


  # =====================================================
  #
  #  connection class method on the Contact class
  #  ... that establishes the connection
  #  ... (using the proper credentials)
  #  ... and returns the connection object.
  #  Your other methods will just be able to make use of it.
  #
  # =====================================================
  def self.connection
     @@conn ||= PG::Connection.open(dbname: 'contact_list')
  end


  # =====================================================
  #
  #  The constructor / initializer.
  #  ... Used to represent a contact instance in memory.
  #  ... Does not talk to the database
  #
  # =====================================================
  def initialize(firstname, lastname, email, id=nil)
    @firstname = firstname
    @lastname = lastname
    @email = email
    @id = id
  end

  # ====================================================
  #
  #  Either inserts or updates a row in the database,
  #  ... as necessary for the given instance of contact.
  #
  # =====================================================
  def save
    # INSERT
    # should then store the id in the instance variable @id, for later use
    # @id = returned value
    # UPDATE
    if id
      # Updates a contact
      self.class.connection.exec_params('UPDATE contacts SET firstname = $1, lastname = $2, email = $3 WHERE id = $4;', [firstname, lastname, email, id])
    else
      # Creates a contact
      res = self.class.connection.exec_params('INSERT INTO contacts (firstname, lastname, email) VALUES ($1, $2, $3) RETURNING id;', [firstname, lastname, email])
      @id = res[0]['id']
    end
  end

  # ===================================================
  #
  # Executes a DELETE SQL command against the database.
  #
  # ==================================================
  def destroy
    # DELETE
    # DELETE FROM contacts WHERE id = 5;
     self.class.connection.exec_params('DELETE FROM contacts WHERE id = $1;', [id])
  end


  # ===============================================
  #
  #  SELECT a contact row from the database by id
  #  ... and return a Contact instance
  #  ... that represents ("maps to") that row.
  #
  # ===============================================
  def self.find(id)
    # SELECT c.id, c.firstname, c.lastname, c.email
    # FROM contacts AS c
    # WHERE c.id = 5;

    # show action in the REPL.
    # When a user asks to see contact #5,
    # our Application can use the Contact.find
    # to retrieve the contact!
    res = connection.exec_params('SELECT * FROM contacts WHERE id = $1;', [id])
    if res.ntuples != 0
      Contact.new(res[0]['firstname'], res[0]['lastname'], res[0]['email'], res[0]['id'])
    else
      nil
    end
  end

  # ===============================================
  #
  #  find_all
  #
  # ===============================================
  def self.find_all
    # SELECT c.id, c.firstname, c.lastname, c.email
    # FROM contacts AS c
    # WHERE c.id = 5;

    # show action in the REPL.
    # When a user asks to see contact #5,
    # our Application can use the Contact.find
    # to retrieve the contact!
    found_contacts = []
    res = connection.exec_params('SELECT * FROM contacts;', [])
    if res != []
      res.each do |contact|
        found_contacts << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'])
      end
    end
    found_contacts

  end

  # =========================================================
  #
  #  returns an array of all contacts
  #  ... that have the provided last name.
  #  ... If none are found, an empty array should be returned.
  #
  # =========================================================
  def self.find_all_by_lastname(lastname)
    found_contacts = []
    res = connection.exec_params('SELECT * FROM contacts WHERE lastname = $1;', [lastname])
    if res != []
      res.each do |contact|
        found_contacts << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'])
      end
    end
    found_contacts
  end


  # =========================================================
  #
  #  returns an array of all contacts
  #  ... that have the provided first name.
  #  ... If none are found, an empty array should be returned.
  #
  # =========================================================
  def self.find_all_by_firstname(firstname)
    found_contacts = []
    res = connection.exec_params('SELECT * FROM contacts WHERE firstname = $1;', [firstname])
    if res != []
      res.each do |contact|
        found_contacts << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'])
      end
    end
    found_contacts

  end

  # =========================================================
  #
  #  returns an array of all contacts
  #  ... that have the provided first name.
  #  ... If none are found, an empty array should be returned.
  #
  # =========================================================
  def self.find_all_by_email(email)
    found_contacts = []
    res = connection.exec_params('SELECT * FROM contacts WHERE email = $1;', [email])
    if res != []
      res.each do |contact|
        found_contacts << Contact.new(contact['firstname'], contact['lastname'], contact['email'], contact['id'])
      end
    end
    found_contacts

  end

  # =======================================================================
  # Task 6.  Prevent duplicate entries
  #
  # If a user tries to input the exact contact
  # with a the same email address twice,
  # the app should output an error saying that the contact already exists
  # and cannot be created.
  # If you are asking for name first and then email,
  # for a better user experience,
  # it may make more sense to ask for their email first and then their name.
  # =======================================================================
  def self.duplicate_email?(email)

    duplicate_flag = false
    contacts = Contact.find_all

    contacts.each do |contact|
      if contact.email == email
        duplicate_flag = true
      end
    end

    duplicate_flag
  end

end

