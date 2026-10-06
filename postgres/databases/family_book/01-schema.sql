CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE accounts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(30) NOT NULL
);

CREATE TABLE transactions (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL REFERENCES accounts(id),
  transaction_date DATE NOT NULL,
  note VARCHAR(100)
);

CREATE TABLE expenses (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name VARCHAR(30) NOT NULL UNIQUE,
  category CHAR(1) NOT NULL CHECK(category IN ('I', 'O'))
);

CREATE TABLE transaction_items (
  transaction_id UUID NOT NULL REFERENCES transactions(id),
  expense_id UUID NOT NULL REFERENCES expenses(id),
  amount INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (transaction_id, expense_id)
);

CREATE TABLE tags (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  author_id UUID NOT NULL REFERENCES accounts(id),
  note VARCHAR(100)
);

CREATE TABLE taggings (
  tag_id UUID NOT NULL REFERENCES tags(id),
  transaction_id UUID NOT NULL REFERENCES transactions(id),
  PRIMARY KEY (tag_id, transaction_id)
);
