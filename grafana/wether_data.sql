CREATE TABLE weather_data (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    temperature_celsius DECIMAL(5,2),
    humidity_percent DECIMAL(5,2),
    aqi INTEGER,
    rainfall_mm DECIMAL(6,2),
    wind_speed_kmh DECIMAL(5,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_weather_timestamp ON weather_data(timestamp);
CREATE INDEX idx_weather_city ON weather_data(city);
CREATE INDEX idx_weather_timestamp_city ON weather_data(timestamp, city);

INSERT INTO weather_data (timestamp, city, state, temperature_celsius, humidity_percent, aqi, rainfall_mm, wind_speed_kmh) VALUES
('2024-07-01 06:00:00', 'Mumbai', 'Maharashtra', 28.5, 78, 156, 12.5, 15.2),
('2024-07-01 06:00:00', 'Delhi', 'Delhi', 35.2, 65, 201, 0.0, 8.7),
('2024-07-01 06:00:00', 'Bangalore', 'Karnataka', 24.8, 72, 89, 8.2, 12.1),
('2024-07-01 06:00:00', 'Chennai', 'Tamil Nadu', 32.1, 82, 134, 15.3, 18.9),
('2024-07-01 06:00:00', 'Kolkata', 'West Bengal', 30.7, 85, 167, 22.1, 14.5),
('2024-07-01 06:00:00', 'Hyderabad', 'Telangana', 29.3, 71, 98, 5.4, 11.8),
('2024-07-01 06:00:00', 'Pune', 'Maharashtra', 26.7, 69, 112, 7.8, 13.2),
('2024-07-01 06:00:00', 'Ahmedabad', 'Gujarat', 33.8, 58, 145, 1.2, 16.4),
('2024-07-01 12:00:00', 'Mumbai', 'Maharashtra', 31.2, 75, 178, 8.7, 17.6),
('2024-07-01 12:00:00', 'Delhi', 'Delhi', 38.5, 58, 234, 0.0, 12.3),
('2024-07-01 12:00:00', 'Bangalore', 'Karnataka', 27.3, 68, 92, 5.1, 14.7),
('2024-07-01 12:00:00', 'Chennai', 'Tamil Nadu', 35.8, 79, 145, 18.9, 22.1),
('2024-07-01 12:00:00', 'Kolkata', 'West Bengal', 33.2, 82, 189, 19.4, 16.8),
('2024-07-01 12:00:00', 'Hyderabad', 'Telangana', 32.1, 67, 105, 3.2, 15.3),
('2024-07-01 12:00:00', 'Pune', 'Maharashtra', 29.4, 65, 125, 4.6, 16.9),
('2024-07-01 12:00:00', 'Ahmedabad', 'Gujarat', 37.2, 52, 167, 0.8, 19.2),
('2024-07-01 18:00:00', 'Mumbai', 'Maharashtra', 29.8, 80, 165, 15.2, 14.1),
('2024-07-01 18:00:00', 'Delhi', 'Delhi', 36.1, 62, 198, 0.0, 9.8),
('2024-07-01 18:00:00', 'Bangalore', 'Karnataka', 25.9, 74, 87, 11.6, 11.4),
('2024-07-01 18:00:00', 'Chennai', 'Tamil Nadu', 33.4, 84, 152, 21.7, 19.7),
('2024-07-01 18:00:00', 'Kolkata', 'West Bengal', 31.8, 87, 176, 25.3, 13.2),
('2024-07-01 18:00:00', 'Hyderabad', 'Telangana', 30.7, 73, 101, 8.7, 12.6),
('2024-07-01 18:00:00', 'Pune', 'Maharashtra', 28.1, 72, 118, 9.3, 14.5),
('2024-07-01 18:00:00', 'Ahmedabad', 'Gujarat', 34.9, 61, 139, 2.1, 17.8),
('2024-07-02 06:00:00', 'Mumbai', 'Maharashtra', 27.9, 81, 148, 18.7, 16.3),
('2024-07-02 06:00:00', 'Delhi', 'Delhi', 34.7, 68, 189, 0.0, 10.2),
('2024-07-02 06:00:00', 'Bangalore', 'Karnataka', 23.5, 75, 85, 14.2, 13.7),
('2024-07-02 06:00:00', 'Chennai', 'Tamil Nadu', 31.8, 85, 128, 24.6, 20.4),
('2024-07-02 06:00:00', 'Kolkata', 'West Bengal', 29.9, 88, 159, 28.9, 15.1),
('2024-07-02 06:00:00', 'Hyderabad', 'Telangana', 28.6, 76, 94, 12.3, 13.8),
('2024-07-02 06:00:00', 'Pune', 'Maharashtra', 25.4, 74, 108, 13.7, 15.2),
('2024-07-02 06:00:00', 'Ahmedabad', 'Gujarat', 32.1, 63, 131, 3.8, 18.9);

SELECT COUNT(*) as total_records FROM weather_data;

SELECT city, COUNT(*) as record_count
FROM weather_data
GROUP BY city
ORDER BY city;

SELECT timestamp, city, temperature_celsius, humidity_percent, aqi
FROM weather_data
ORDER BY timestamp DESC, city;

SELECT
    city,
    ROUND(AVG(temperature_celsius), 2) as avg_temperature,
    ROUND(AVG(humidity_percent), 2) as avg_humidity,
    ROUND(AVG(aqi), 0) as avg_aqi
FROM weather_data
GROUP BY city
ORDER BY avg_temperature DESC;

SELECT
    timestamp,
    ROUND(AVG(temperature_celsius), 2) as avg_temperature,
    ROUND(AVG(humidity_percent), 2) as avg_humidity
FROM weather_data
GROUP BY timestamp
ORDER BY timestamp;

SELECT
    timestamp as time,
    temperature_celsius as value,
    city as metric
FROM weather_data
WHERE timestamp >= NOW() - INTERVAL '7 days'
ORDER BY timestamp, city;

SELECT
    timestamp as time,
    temperature_celsius as "Temperature (°C)",
    humidity_percent as "Humidity (%)",
    aqi as "Air Quality Index"
FROM weather_data
WHERE city = 'Delhi'
ORDER BY timestamp;