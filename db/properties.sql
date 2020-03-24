DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value VARCHAR(255),
  number_of_bedrooms INT,
  buy_let_status VARCHAR(255)
)
