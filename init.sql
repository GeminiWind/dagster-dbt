-- Migrations will appear here as you chat with AI

create table users (
  id bigint primary key generated always as identity,
  name text not null,
  email text unique not null,
  created_at timestamp with time zone default now() not null
);

create table products (
  id bigint primary key generated always as identity,
  name text not null,
  description text,
  price numeric(10, 2) not null,
  created_at timestamp with time zone default now() not null
);

create table orders (
  id bigint primary key generated always as identity,
  user_id bigint not null references users (id),
  order_date timestamp with time zone default now() not null
);

create table order_items (
  id bigint primary key generated always as identity,
  order_id bigint not null references orders (id),
  product_id bigint not null references products (id),
  quantity int not null,
  price numeric(10, 2) not null
);

INSERT INTO users (name, email) VALUES
  ('Alice Johnson', 'alice@example.com'),
  ('Bob Smith', 'bob@example.com'),
  ('Carol Lee', 'carol@example.com');

INSERT INTO products (name, description, price) VALUES
  ('Laptop', '15-inch display, 16GB RAM', 1299.99),
  ('Smartphone', '6.1-inch screen, 128GB storage', 799.49),
  ('Headphones', 'Noise-cancelling wireless headphones', 199.99);

INSERT INTO orders (user_id, order_date) VALUES
  (1, now() - interval '2 days'),
  (2, now() - interval '1 day');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES
  (1, 1, 1, 1299.99),  -- Alice bought 1 Laptop
  (1, 3, 2, 199.99),   -- Alice bought 2 Headphones
  (2, 2, 1, 799.49);   -- Bob bought 1 Smartphone