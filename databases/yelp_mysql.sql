CREATE TABLE business (
    bid BIGINT,
    business_id TEXT,
    name TEXT,
    full_address TEXT,
    city TEXT,
    latitude TEXT,
    longitude TEXT,
    review_count BIGINT,
    is_open BIGINT,
    state TEXT
);


CREATE TABLE category (
    id BIGINT,
    business_id TEXT,
    category_name TEXT
);


CREATE TABLE checkin (
    cid BIGINT,
    business_id TEXT,
    count BIGINT,
    day TEXT
);


CREATE TABLE neighbourhood (
    id BIGINT,
    business_id TEXT,
    neighbourhood_name TEXT
);


CREATE TABLE review (
    rid BIGINT,
    business_id TEXT,
    user_id TEXT,
    rating real,
    TEXT TEXT,
    year BIGINT,
    month TEXT
);


CREATE TABLE tip (
    tip_id BIGINT,
    business_id TEXT,
    TEXT TEXT,
    user_id TEXT,
    likes BIGINT,
    year BIGINT,
    month TEXT
);


CREATE TABLE users (
    uid BIGINT,
    user_id TEXT,
    name TEXT
);


INSERT INTO business (bid, business_id, name, full_address, city, latitude, longitude, review_count, is_open, state) VALUES
(1, 'abc123', 'Joe’s Pizza', '123 Main St', 'San Francisco', '37.7749295', '-122.4194155', 3, 0, 'CA'),
(2, 'def456', 'Peter’s Cafe', '456 Elm St', 'New York', '40.712776', '-74.005974', 4, 1, 'NY'),
(3, 'ghi789', 'Anna’s Diner', '789 Oak St', 'Los Angeles', '34.052235', '-118.243683', 5, 0, 'CA'),
(4, 'jkl012', 'Mark’s Bistro', '012 Maple St', 'San Francisco', '37.7749295', '-122.4194155', 4, 1, 'CA'),
(5, 'mno345', 'Lily’s Bakery', '345 Walnut St', 'New York', '40.712776', '-74.005974', 3, 1, 'NY'),
(6, 'xyz123', 'Izza’s Pizza', '83 Main St', 'San Francisco', '37.8749295', '-122.5194155', 2, 1, 'CA'),
(7, 'uvw456', 'Sashays Cafe', '246 Elm St', 'New York', '40.812776', '-74.105974', 2, 1, 'NY')
;

INSERT INTO category (id, business_id, category_name) VALUES
(1, 'abc123', 'Pizza'),
(2, 'def456', 'Cafe'),
(3, 'ghi789', 'Diner'),
(4, 'jkl012', 'Bistro'),
(5, 'mno345', 'Bakery'),
(1, 'xyz123', 'Pizza'),
(2, 'uvw456', 'Cafe')
;

INSERT INTO checkin (cid, business_id, count, day) VALUES
(1, 'abc123', 10, 'Monday'),
(2, 'def456', 20, 'Tuesday'),
(3, 'ghi789', 15, 'Wednesday'),
(4, 'jkl012', 30, 'Thursday'),
(5, 'mno345', 25, 'Friday'),
(6, 'abc123', 13, 'Tuesday'),
(7, 'def456', 14, 'Wednesday'),
(8, 'ghi789', 8, 'Thursday'),
(9, 'jkl012', 21, 'Saturday'),
(10, 'mno345', 24, 'Friday'),
(11, 'xyz123', 10, 'Saturday'),
(12, 'uvw456', 2, 'Monday')
;

INSERT INTO neighbourhood (id, business_id, neighbourhood_name) VALUES
(1, 'abc123', 'Downtown'),
(2, 'def456', 'Midtown'),
(3, 'ghi789', 'Hollywood'),
(4, 'jkl012', 'Downtown'),
(5, 'mno345', 'Upper East Side'),
(6, 'xyz123', 'Downtown'),
(7, 'uvw456', 'Midtown')
;

INSERT INTO review (rid, business_id, user_id, rating, TEXT, year, month) VALUES
(1, 'abc123', '1', 4.5, 'Great pizza!', 2021, 'January'),
(2, 'def456', '2', 4.2, 'Delicious food.', 2021, 'February'),
(3, 'ghi789', '3', 3.9, 'Average diner.', 2021, 'March'),
(4, 'jkl012', '4', 4.8, 'Amazing bistro.', 2021, 'April'),
(5, 'mno345', '5', 4.6, 'Yummy bakery.', 2021, 'January'),
(6, 'ghi789', '1', 1.2, 'Horrible staff!', 2021, 'April'),
(7, 'def456', '2', 4.9, 'Second visit. I’m loving it.', 2021, 'May'),
(8, 'xyz123', '3', 0.5, 'Hate it', 2021, 'June'),
(9, 'uvw456', '4', 4.0, 'Not bad.', 2021, 'July'),
(10, 'abc123', '5', 4.6, 'Very goody.', 2022, 'January'),
(11, 'def456', '1', 3.0, 'Average', 2022, 'February'),
(12, 'ghi789', '2', 4.0, 'Not bad.', 2022, 'March'),
(13, 'jkl012', '3', 4.5, 'Second time here.', 2022, 'April'),
(14, 'mno345', '4', 4.6, 'Third time here.', 2022, 'May'),
(15, 'xyz123', '5', 3.5, 'Wont come again.', 2022, 'June'),
(16, 'uvw456', '1', 4.0, 'Quite good.', 2022, 'July'),
(17, 'mno345', '2', 4.6, 'Superb.', 2022, 'July'),
(18, 'jkl012', '3', 5.0, 'WOwowow.', 2022, 'August'),
(19, 'jkl012', '4', 4.8, 'Lovin it.', 2022, 'September'),
(20, 'ghi789', '5', 1.5, 'Worst experience ever.', EXTRACT(YEAR FROM CURRENT_DATE - INTERVAL '15 months'), TO_CHAR(CURRENT_DATE - INTERVAL '15 months', 'Month')),
(21, 'abc123', '1', 4.6, 'Very goody.', EXTRACT(YEAR FROM CURRENT_DATE - INTERVAL '9 months'), TO_CHAR(CURRENT_DATE - INTERVAL '9 months', 'Month')),
(22, 'def456', '2', 3.0, 'Average', EXTRACT(YEAR FROM CURRENT_DATE - INTERVAL '8 months'), TO_CHAR(CURRENT_DATE - INTERVAL '8 months', 'Month')),
(23, 'ghi789', '3', 4.0, 'Not bad.', EXTRACT(YEAR FROM CURRENT_DATE - INTERVAL '7 months'), TO_CHAR(CURRENT_DATE - INTERVAL '7 months', 'Month'))
;

INSERT INTO tip (tip_id, business_id, TEXT, user_id, likes, year, month) VALUES
(1, 'abc123', 'Try their pepperoni pizza!', '1', NULL, 2021, 'January'),
(2, 'def456', 'Their coffee is amazing.', '2', NULL, 2021, 'February'),
(3, 'ghi789', 'The pancakes are delicious.', '3', NULL, 2021, 'March'),
(4, 'jkl012', 'Highly recommend the steak.', '4', NULL, 2021, 'April'),
(5, 'mno345', 'Their pastries are to die for.', '5', NULL, 2021, 'May'),
(6, 'xyz123', 'Don’t waste your money.', '1', NULL, 2021, 'June'),
(7, 'uvw456', 'Not bad.', '2', NULL, 2021, 'July'),
(8, 'mno345', 'Get the blueberry pancakes!', '1', NULL, 2022, 'January'),
(9, 'abc123', 'Try their pepperoni pizza!', '1', NULL, 2022, 'January'),
(10, 'def456', 'Their coffee is amazing.', '2', NULL, 2022, 'February'),
(11, 'ghi789', 'The pancakes are delicious.', '3', NULL, 2022, 'March'),
(12, 'jkl012', 'Highly recommend the steak.', '4', NULL, 2022, 'April'),
(13, 'mno345', 'Their pastries are to die for.', '5', NULL, 2022, 'May'),
(14, 'xyz123', 'Don’t waste your money.', '1', NULL, 2022, 'June'),
(15, 'uvw456', 'So-so.', '2', NULL, 2022, 'July'),
(16, 'mno345', 'Second time having blueberry pancakes!', '1', NULL, 2022, 'July'),
(17, 'jkl012', 'Great happy hour deals.', '5', NULL, 2022, 'August'),
(18, 'jkl012', 'Ask for extra sauce.', '3', NULL, 2022, 'September'),
(19, 'ghi789', 'Friendly staff.', '4', NULL, 2022, 'October'),
(20, 'def456', 'Tasty lattes.', '4', NULL, 2022, 'November'),
(21, 'abc123', 'Fresh ingredients.', '2', NULL, 2022, 'December')
;

INSERT INTO users (uid, user_id, name) VALUES
(1, '1', 'John Doe'),
(2, '2', 'Jane Smith'),
(3, '3', 'David Johnson'),
(4, '4', 'Sarah Williams'),
(5, '5', 'Michael Brown')
;



