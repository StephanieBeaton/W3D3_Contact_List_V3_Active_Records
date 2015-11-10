
class Contact

  # =====================================================
  #
  #  The constructor / initializer.
  #  ... Used to represent a contact instance in memory.
  #  ... Does not talk to the database
  #
  # =====================================================
  def self.new(firstname, lastname, email)

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
  end

  # ===================================================
  #
  # Executes a DELETE SQL command against the database.
  #
  # ==================================================
  def destroy
    # DELETE
    # DELETE FROM contacts WHERE id = 5;
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
  end


  # =========================================================
  #
  #  returns an array of all contacts
  #  ... that have the provided last name.
  #  ... If none are found, an empty array should be returned.
  #
  # =========================================================
  def self.find_all_by_lastname(name)

  end


  # =========================================================
  #
  #  returns an array of all contacts
  #  ... that have the provided first name.
  #  ... If none are found, an empty array should be returned.
  #
  # =========================================================
  def self.find_all_by_firstname(name)

  end

end

