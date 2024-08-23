CREATE TABLE aircraft (
    aircraft_code TEXT,
    aircraft_description TEXT,
    manufacturer TEXT,
    basic_type TEXT,
    engines BIGINT,
    propulsion TEXT,
    wide_body TEXT,
    wing_span BIGINT,
    length BIGINT,
    weight BIGINT,
    capacity BIGINT,
    pay_load BIGINT,
    cruising_speed BIGINT,
    range_miles BIGINT,
    pressurized TEXT
);


CREATE TABLE airline (
    airline_code TEXT,
    airline_name TEXT,
    note TEXT
);


CREATE TABLE airport (
    airport_code TEXT,
    airport_name TEXT,
    airport_location TEXT,
    state_code TEXT,
    country_name TEXT,
    time_zone_code TEXT,
    minimum_connect_time BIGINT
);


CREATE TABLE airport_service (
    city_code TEXT,
    airport_code TEXT,
    miles_distant BIGINT,
    direction TEXT,
    minutes_distant BIGINT
);


CREATE TABLE city (
    city_code TEXT,
    city_name TEXT,
    state_code TEXT,
    country_name TEXT,
    time_zone_code TEXT
);


CREATE TABLE class_of_service (
    booking_class TEXT DEFAULT '' NOT NULL,
    tier BIGINT,
    class_description TEXT
);


CREATE TABLE code_description (
    code TEXT DEFAULT '' NOT NULL,
    description TEXT
);


CREATE TABLE compartment_class (
    compartment TEXT,
    class_type TEXT
);


CREATE TABLE days (
    days_code TEXT,
    day_name TEXT
);


CREATE TABLE dual_carrier (
    main_airline TEXT,
    low_flight_number BIGINT,
    high_flight_number BIGINT,
    dual_airline TEXT,
    service_name TEXT
);


CREATE TABLE equipment_sequence (
    aircraft_code_sequence TEXT,
    aircraft_code TEXT
);


CREATE TABLE fare (
    fare_id BIGINT DEFAULT '0' NOT NULL,
    from_airport TEXT,
    to_airport TEXT,
    fare_basis_code TEXT,
    fare_airline TEXT,
    restriction_code TEXT,
    one_direction_cost BIGINT,
    round_trip_cost BIGINT,
    round_trip_required TEXT
);


CREATE TABLE fare_basis (
    fare_basis_code TEXT,
    booking_class TEXT,
    class_type TEXT,
    premium TEXT,
    economy TEXT,
    discounted TEXT,
    night TEXT,
    season TEXT,
    basis_days TEXT
);


CREATE TABLE flight (
    flight_id BIGINT DEFAULT '0' NOT NULL,
    flight_days TEXT,
    from_airport TEXT,
    to_airport TEXT,
    departure_time BIGINT,
    arrival_time BIGINT,
    airline_flight TEXT,
    airline_code TEXT,
    flight_number TEXT,
    aircraft_code_sequence TEXT,
    meal_code TEXT,
    stops BIGINT,
    connections BIGINT,
    dual_carrier TEXT,
    time_elapsed BIGINT
);


CREATE TABLE flight_fare (
    flight_id BIGINT,
    fare_id BIGINT
);


CREATE TABLE flight_leg (
    flight_id BIGINT,
    leg_number BIGINT,
    leg_flight BIGINT
);


CREATE TABLE flight_stop (
    flight_id BIGINT,
    stop_number BIGINT,
    stop_days TEXT,
    stop_airport TEXT,
    arrival_time BIGINT,
    arrival_airline TEXT,
    arrival_flight_number TEXT,
    departure_time BIGINT,
    departure_airline TEXT,
    departure_flight_number TEXT,
    stop_time BIGINT
);


CREATE TABLE food_service (
    meal_code TEXT,
    meal_number BIGINT,
    compartment TEXT,
    meal_description TEXT
);


CREATE TABLE ground_service (
    city_code TEXT,
    airport_code TEXT,
    transport_type TEXT,
    ground_fare BIGINT
);


CREATE TABLE month (
    month_number BIGINT,
    month_name TEXT
);


CREATE TABLE restriction (
    restriction_code TEXT,
    advance_purchase BIGINT,
    stopovers TEXT,
    saturday_stay_required TEXT,
    minimum_stay BIGINT,
    maximum_stay BIGINT,
    application TEXT,
    no_discounts TEXT
);


CREATE TABLE state (
    state_code TEXT,
    state_name TEXT,
    country_name TEXT
);


CREATE TABLE time_interval (
    period TEXT,
    begin_time BIGINT,
    end_time BIGINT
);


CREATE TABLE time_zone (
    time_zone_code TEXT,
    time_zone_name TEXT,
    hours_from_gmt BIGINT
);


INSERT INTO aircraft (aircraft_code, aircraft_description, manufacturer, basic_type, engines, propulsion, wide_body, wing_span, length, weight, capacity, pay_load, cruising_speed, range_miles, pressurized) VALUES
('B747', 'The Boeing 747 is a wide-body airliner.', 'Boeing', 'Jet', 4, 'Jet', 'Yes', 224, 231, 987000, 416, 60000, 570, 8555, 'Yes'),
('A320', 'The Airbus A320 is a narrow-body airliner.', 'Airbus', 'Jet', 2, 'Jet', 'No', 111, 123, 162000, 240, 30000, 511, 3300, 'Yes'),
('B737', 'The Boeing 737 is a narrow-body airliner.', 'Boeing', 'Jet', 2, 'Jet', 'No', 117, 128, 174200, 230, 35000, 514, 3850, 'Yes'),
('A380', 'The Airbus A380 is a wide-body airliner.', 'Airbus', 'Jet', 4, 'Jet', 'Yes', 261, 238, 1235000, 853, 140000, 560, 8000, 'Yes'),
('B777', 'The Boeing 777 is a wide-body airliner.', 'Boeing', 'Jet', 2, 'Jet', 'Yes', 199, 242, 775000, 550, 70000, 560, 8555, 'Yes'),
('A330', 'The Airbus A330 is a wide-body airliner.', 'Airbus', 'Jet', 2, 'Jet', 'Yes', 197, 193, 503000, 440, 65000, 560, 6350, 'Yes'),
('B787', 'The Boeing 787 is a wide-body airliner.', 'Boeing', 'Jet', 2, 'Jet', 'Yes', 197, 186, 485000, 330, 55000, 593, 7530, 'Yes'),
('A350', 'The Airbus A350 is a wide-body airliner.', 'Airbus', 'Jet', 2, 'Jet', 'Yes', 212, 242, 556000, 440, 70000, 568, 8000, 'Yes'),
('E190', 'The Embraer E190 is a narrow-body airliner.', 'Embraer', 'Jet', 2, 'Jet', 'No', 94, 118, 114000, 114, 15000, 542, 2400, 'Yes'),
('CRJ200', 'The Bombardier CRJ200 is a regional jet.', 'Bombardier', 'Jet', 2, 'Jet', 'No', 76, 88, 51000, 50, 6300, 534, 1735, 'Yes')
;

INSERT INTO airline (airline_code, airline_name, note) VALUES
('AA', 'American Airlines', NULL),
('UA', 'United Airlines', NULL),
('DL', 'Delta Air Lines', NULL),
('WN', 'Southwest Airlines', NULL),
('AS', 'Alaska Airlines', NULL),
('B6', 'JetBlue Airways', NULL),
('NK', 'Spirit Airlines', NULL),
('F9', 'Frontier Airlines', NULL),
('HA', 'Hawaiian Airlines', NULL),
('VX', 'Virgin America', NULL)
;

INSERT INTO airport (airport_code, airport_name, airport_location, state_code, country_name, time_zone_code, minimum_connect_time) VALUES
('JFK', 'John F. Kennedy International Airport', 'New York City', 'NY', 'United States', 'EST', 23),
('LAX', 'Los Angeles International Airport', 'Los Angeles', 'CA', 'United States', 'PST', 20),
('ORD', 'O’Hare International Airport', 'Chicago', 'IL', 'United States', 'CST', 24),
('DFW', 'Dallas/Fort Worth International Airport', 'Dallas', 'TX', 'United States', 'CST', 40),
('DEN', 'Denver International Airport', 'Denver', 'CO', 'United States', 'MST', 42),
('ATL', 'Hartsfield-Jackson Atlanta International Airport', 'Atlanta', 'GA', 'United States', 'EST', 10),
('SFO', 'San Francisco International Airport', 'San Francisco', 'CA', 'United States', 'PST', 49),
('SEA', 'Seattle-Tacoma International Airport', 'Seattle', 'WA', 'United States', 'PST', 50),
('LAS', 'McCarran International Airport', 'Las Vegas', 'NV', 'United States', 'PST', 30),
('MCO', 'Orlando International Airport', 'Orlando', 'FL', 'United States', 'EST', 50)
;

INSERT INTO airport_service (city_code, airport_code, miles_distant, direction, minutes_distant) VALUES
('NYC', 'JFK', 10, 'North', 20),
('NYC', 'JFK', 20, 'South', 40),
('NYC', 'JFK', 30, 'East', 60),
('NYC', 'JFK', 40, 'West', 80),
('NYC', 'JFK', 50, 'Northeast', 100),
('NYC', 'JFK', 60, 'Northwest', 120),
('NYC', 'JFK', 70, 'Southeast', 140),
('NYC', 'JFK', 80, 'Southwest', 160),
('NYC', 'JFK', 90, 'North', 180),
('NYC', 'JFK', 100, 'South', 200),
('LA', 'LAX', 15, 'West', 30),
('LA', 'LAX', 25, 'East', 50),
('DA', 'DAL Love Field', 5, 'North', 10),
('DA', 'DAL Love Field', 10, 'South', 20),
('SF', 'SFO', 12, 'North', 24),
('SF', 'SFO', 22, 'South', 44)
;

INSERT INTO city (city_code, city_name, state_code, country_name, time_zone_code) VALUES
('NYC', 'New York', 'NY', 'United States', 'EST'),
('LA', 'Los Angeles', 'CA', 'United States', 'PST'),
('CHI', 'Chicago', 'IL', 'United States', 'CST'),
('DA', 'Dallas', 'TX', 'United States', 'CST'),
('DEN', 'Denver', 'CO', 'United States', 'MST'),
('ATL', 'Atlanta', 'GA', 'United States', 'EST'),
('SF', 'San Francisco', 'CA', 'United States', 'PST'),
('SEA', 'Seattle', 'WA', 'United States', 'PST'),
('LAS', 'Las Vegas', 'NV', 'United States', 'PST'),
('ORL', 'Orlando', 'FL', 'United States', 'EST')
;

INSERT INTO class_of_service (booking_class, tier, class_description) VALUES
('First', 1, 'First Class'),
('Business', 2, 'Business Class'),
('Economy', 3, 'Economy Class')
;

INSERT INTO code_description (code, description) VALUES
('ABC', 'Code ABC'),
('DEF', 'Code DEF'),
('GHI', 'Code GHI'),
('JKL', 'Code JKL'),
('MNO', 'Code MNO'),
('PQR', 'Code PQR'),
('STU', 'Code STU'),
('VWX', 'Code VWX'),
('YZ', 'Code YZ'),
('AAA', 'Code AAA')
;

INSERT INTO compartment_class (compartment, class_type) VALUES
('First', 'First Class'),
('Business', 'Business Class'),
('Economy', 'Economy Class')
;

INSERT INTO days (days_code, day_name) VALUES
('1', 'Monday'),
('2', 'Tuesday'),
('3', 'Wednesday'),
('4', 'Thursday'),
('5', 'Friday'),
('6', 'Saturday'),
('7', 'Sunday')
;

INSERT INTO dual_carrier (main_airline, low_flight_number, high_flight_number, dual_airline, service_name) VALUES
('AA', 1, 10, 'VX', 'Dual Service 1'),
('UA', 11, 20, 'DL', 'Dual Service 2'),
('DL', 21, 30, 'UA', 'Dual Service 3'),
('WN', 31, 40, 'AS', 'Dual Service 4'),
('AS', 41, 50, 'WN', 'Dual Service 5'),
('B6', 51, 60, 'NK', 'Dual Service 6'),
('NK', 61, 70, 'B6', 'Dual Service 7'),
('F9', 71, 80, 'HA', 'Dual Service 8'),
('HA', 81, 90, 'F9', 'Dual Service 9'),
('VX', 91, 100, 'AA', 'Dual Service 10')
;

INSERT INTO equipment_sequence (aircraft_code_sequence, aircraft_code) VALUES
('1', 'B747'),
('2', 'A320'),
('3', 'B737'),
('4', 'A380'),
('5', 'B777'),
('6', 'A330'),
('7', 'B787'),
('8', 'A350'),
('9', 'E190'),
('10', 'CRJ200')
;

INSERT INTO fare (fare_id, from_airport, to_airport, fare_basis_code, fare_airline, restriction_code, one_direction_cost, round_trip_cost, round_trip_required) VALUES
(1, 'ORD', 'JFK', 'ABC', 'AA', 'NONE', 200, 300, 'Yes'),
(2, 'ORD', 'JFK', 'DEF', 'UA', 'NONE', 150, 280, 'No'),
(3, 'ORD', 'JFK', 'GHI', 'AA', 'NONE', 180, 300, 'No'),
(4, 'ORD', 'JFK', 'JKL', 'WN', 'NONE', 250, 350, 'Yes'),
(5, 'ORD', 'LAX', 'MNO', 'AS', 'BLACKOUT', 220, 400, 'Yes'),
(6, 'JFK', 'ORD', 'PQR', 'AA', 'BLACKOUT', 190, 350, 'Yes'),
(7, 'JFK', 'ORD', 'STU', 'UA', 'NONE', 210, 400, 'Yes'),
(8, 'JFK', 'LAX', 'VWX', 'F9', 'NONE', 230, 400, 'No'),
(9, 'LAX', 'ORD', 'YZ', 'HA', 'NONE', 240, 400, 'No'),
(10, 'LAX', 'ORD', 'AAA', 'VX', 'NONE', 270, 500, 'No')
;

INSERT INTO fare_basis (fare_basis_code, booking_class, class_type, premium, economy, discounted, night, season, basis_days) VALUES
('ABC', 'First', 'First Class', 'Yes', 'No', 'No', 'No', 'Regular', '30'),
('DEF', 'Business', 'Business Class', 'Yes', 'No', 'No', 'No', 'Regular', '30'),
('GHI', 'Economy', 'Economy Class', 'No', 'Yes', 'Yes', 'No', 'Regular', '30'),
('JKL', 'First', 'First Class', 'Yes', 'No', 'No', 'No', 'Regular', '30'),
('MNO', 'Business', 'Business Class', 'Yes', 'No', 'No', 'No', 'Regular', '30'),
('PQR', 'Economy', 'Economy Class', 'No', 'Yes', 'Yes', 'No', 'Regular', '30'),
('STU', 'First', 'First Class', 'Yes', 'No', 'No', 'No', 'Regular', '30'),
('VWX', 'Business', 'Business Class', 'Yes', 'No', 'No', 'No', 'Regular', '30'),
('YZ', 'Economy', 'Economy Class', 'No', 'Yes', 'Yes', 'No', 'Regular', '30'),
('AAA', 'First', 'First Class', 'Yes', 'No', 'No', 'No', 'Regular', '30')
;

INSERT INTO flight (flight_id, flight_days, from_airport, to_airport, departure_time, arrival_time, airline_flight, airline_code, flight_number, aircraft_code_sequence, meal_code, stops, connections, dual_carrier, time_elapsed) VALUES
(1, 'mon,wed', 'ORD', 'JFK', 1577836800, 1577840400, 'AA123', 'AA', 'AA123', '1', 'BF', 0, 0, 'AA123', 3600),
(2, 'tue,thu', 'ORD', 'JFK', 1577844000, 1577854000, 'UA456', 'UA', 'UA456', '2', 'LN', 1, 1, 'UA456', 10000),
(3, 'wed', 'ORD', 'JFK', 1577851200, 1577854900, 'AA789', 'AA', 'AA789', '3', 'DN', 0, 0, 'AA789', 3700),
(4, 'thu', 'ORD', 'JFK', 1577858400, 1577873400, 'WN012', 'WN', 'WN012', '4', 'BS', 1, 1, 'WN012', 15000),
(5, 'fri', 'ORD', 'LAX', 1577865600, 1577869600, 'AS345', 'AS', 'AS345', '5', 'BF', 0, 0, 'AS345', 4000),
(6, 'sat,mon', 'JFK', 'ORD', 1577872800, 1577884800, 'AA124', 'AA', 'AA123', '6', 'LN', 1, 1, 'B678', 12000),
(7, 'sun', 'JFK', 'ORD', 1577880000, 1577883700, 'UA457', 'UA', 'UA457', '7', 'DN', 0, 0, 'UA457', 3700),
(8, 'mon', 'JFK', 'LAX', 1577887200, 1577897200, 'F934', 'F9', 'F934', '8', 'BS', 1, 1, 'F934', 10000),
(9, 'tue', 'LAX', 'ORD', 1577894400, 1577898400, 'HA567', 'HA', 'HA567', '9', 'LS', 0, 0, 'HA567', 4000),
(10, 'wed,mon', 'LAX', 'ORD', 1577901600, 1577921600, 'VX890', 'VX', 'VX890', '10', 'DS', 1, 1, 'VX890', 20000)
;

INSERT INTO flight_fare (flight_id, fare_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10)
;

INSERT INTO flight_leg (flight_id, leg_number, leg_flight) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 7),
(8, 1, 8),
(9, 1, 9),
(10, 1, 10)
;

INSERT INTO flight_stop (flight_id, stop_number, stop_days, stop_airport, arrival_time, arrival_airline, arrival_flight_number, departure_time, departure_airline, departure_flight_number, stop_time) VALUES
(2, 1, '2', 'DFW', 1577847600, 'UA', 'UA456', 1577851200, 'UA', 'UA456', 3600),
(4, 1, '4', 'DEN', 1577862000, 'WN', 'WN012', 1577865600, 'WN', 'WN012', 3600),
(6, 1, '6', 'DFW', 1577876400, 'AA', 'AA123', 1577880000, 'AA', 'AA123', 3600),
(8, 1, '1', 'LAX', 1577890800, 'F9', 'F934', 1577894400, 'F9', 'F934', 3600),
(10, 1, '3', 'JFK', 1577905200, 'VX', 'VX890', 1577908800, 'VX', 'VX890', 3600)
;

INSERT INTO food_service (meal_code, meal_number, compartment, meal_description) VALUES
('BF', 1, 'First Class', 'Breakfast'),
('LN', 2, 'First Class', 'Lunch'),
('DN', 3, 'First Class', 'Dinner'),
('BS', 4, 'Economy', 'Breakfast'),
('LS', 5, 'Economy', 'Lunch'),
('DS', 6, 'Economy', 'Dinner')
;

INSERT INTO ground_service (city_code, airport_code, transport_type, ground_fare) VALUES
('NYC', 'JFK', 'Taxi', 50),
('NYC', 'JFK', 'Shuttle', 40),
('NYC', 'JFK', 'Bus', 30),
('NYC', 'JFK', 'Car Rental', 60),
('NYC', 'JFK', 'Limousine', 70),
('NYC', 'JFK', 'Train', 80),
('NYC', 'JFK', 'Subway', 90),
('NYC', 'JFK', 'Private Car', 100),
('NYC', 'JFK', 'Shared Ride', 110),
('NYC', 'JFK', 'Helicopter', 120)
;

INSERT INTO month (month_number, month_name) VALUES
(1, 'January'),
(2, 'February'),
(3, 'March'),
(4, 'April'),
(5, 'May'),
(6, 'June'),
(7, 'July'),
(8, 'August'),
(9, 'September'),
(10, 'October'),
(11, 'November'),
(12, 'December')
;

INSERT INTO restriction (restriction_code, advance_purchase, stopovers, saturday_stay_required, minimum_stay, maximum_stay, application, no_discounts) VALUES
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes'),
('NONE', 14, '2', 'No', 7, 30, 'One-Way', 'Yes')
;

INSERT INTO state (state_code, state_name, country_name) VALUES
('NY', 'New York', 'United States'),
('CA', 'California', 'United States'),
('IL', 'Illinois', 'United States'),
('TX', 'Texas', 'United States'),
('CO', 'Colorado', 'United States'),
('GA', 'Georgia', 'United States'),
('WA', 'Washington', 'United States'),
('NV', 'Nevada', 'United States'),
('FL', 'Florida', 'United States')
;

INSERT INTO time_interval (period, begin_time, end_time) VALUES
('daily', 1577836800, 1577840400),
('daily', 1577844000, 1577847600),
('daily', 1577851200, 1577854800),
('daily', 1577858400, 1577862000),
('daily', 1577865600, 1577869200),
('daily', 1577872800, 1577876400),
('daily', 1577880000, 1577883600),
('daily', 1577887200, 1577890800),
('daily', 1577894400, 1577898000),
('daily', 1577901600, 1577905200)
;

INSERT INTO time_zone (time_zone_code, time_zone_name, hours_from_gmt) VALUES
('PST', 'Pacific Standard Time', -8),
('MST', 'Mountain Standard Time', -7),
('CST', 'Central Standard Time', -6),
('EST', 'Eastern Standard Time', -5)
;



