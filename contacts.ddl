CREATE TABLE contacts(
  id        serial   NOT NULL PRIMARY KEY,
  firstname varchar(40)  NOT NULL,
  lastname  varchar(40)  NOT NULL,
  email     varchar(40)  NOT NULL
);


INSERT INTO contacts (firstname, lastname, email) VALUES
                     ('Sam', 'Jones', 'samjones@test.com');

INSERT INTO contacts (firstname, lastname, email) VALUES
                     ('Sam', 'Smith', 'samsmith@test.com');

INSERT INTO contacts (firstname, lastname, email) VALUES
                     ('Sam', 'MacTavish', 'sammactavish@test.com');

INSERT INTO contacts (firstname, lastname, email) VALUES
                     ('Jim', 'Smith', 'sammactavish@test.com');

CREATE TABLE phones(
  id        serial   NOT NULL PRIMARY KEY,
  digit     varchar(1000),
  type      varchar(50),
  contact_id INTEGER
);

INSERT INTO phones(digit, type, contact_id) VALUES
                  ('6041112222', 'cell', 1);

INSERT INTO phones(digit, type, contact_id) VALUES
                  ('6049993333', 'cell', 1);

INSERT INTO phones(digit, type, contact_id) VALUES
                  ('6047772222', 'cell', 2);


