
CREATE DATABASE IF NOT EXISTS water_intake_db;
USE water_intake_db;

CREATE TABLE IF NOT EXISTS water_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    person VARCHAR(40) NOT NULL,
    log_date DATE NOT NULL,
    glasses INT NOT NULL
);

INSERT INTO water_log (person, log_date, glasses)
VALUES
('Aai', '2026-10-26', 8),
('Baba', '2026-10-27', 6),
('Me', '2026-10-28', 10);
