CREATE TABLE contacts(
  id        serial   NOT NULL PRIMARY KEY,
  firstname varchar(40)  NOT NULL,
  lastname  varchar(40)  NOT NULL,
  email     varchar(40)  NOT NULL
);


INSERT INTO contacts (id, firstname, lastname, email) VALUES
                     (1, 'Sam', 'Jones', 'samjones@test.com');

INSERT INTO contacts (id, firstname, lastname, email) VALUES
                     (2, 'Sam', 'Smith', 'samsmith@test.com');

INSERT INTO contacts (id, firstname, lastname, email) VALUES
                     (3, 'Sam', 'MacTavish', 'sammactavish@test.com');
