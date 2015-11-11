class Phone

  attr_accessor  :digit, :ph_type, :contact_id

  attr_reader    :id


  # =====================================================
  #
  #  connection class method on the Phone class
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
  #  ... Used to represent a phone instance in memory.
  #  ... Does not talk to the database
  #
  # =====================================================
  def initialize(digit, ph_type, contact_id = nil, id = nil)
    @digit = digit
    @ph_type = ph_type
    @contact_id = contact_id
  end

  # ====================================================
  #
  #  Either inserts or updates a row in the database,
  #  ... as necessary for the given instance of phone.
  #
  # =====================================================
  def save
    if id
      # Updates a phone
      binding.pry
      self.class.connection.exec_params('UPDATE phones SET digit = $1,  contact_id = $3 WHERE id = $4;', [digit,  contact_id, id])
    else
      # Creates a phone
      # should then store the id in the instance variable @id, for later use
      # @id = returned value

      binding.pry
      res = self.class.connection.exec_params('INSERT INTO phones (digit, contact_id) VALUES ($1, $2) RETURNING id;', [digit, contact_id])
      @id = res[0]['id']
      binding.pry
    end
  end

  # ===================================================
  #
  # Executes a DELETE SQL command against the database.
  #
  # ==================================================
  def destroy
    # DELETE
    # DELETE FROM phone WHERE id = 5;
     binding.pry
     self.class.connection.exec_params('DELETE FROM phones WHERE id = $1;', [id])
     binding.pry
  end


  # ===============================================
  #
  #  SELECT a phone row from the database by id
  #  ... and return a Phone instance
  #  ... that represents ("maps to") that row.
  #
  # ===============================================
  def self.find(id)

    res = connection.exec_params('SELECT * FROM phones WHERE id = $1;', [id])
    Phone.new(res[0]['digit'], res[0]['ph_type'], res[0]['id'])
  end


end
