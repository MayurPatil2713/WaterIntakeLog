
# Water Intake Log

A simple Java JSP and MySQL web application to record and view daily water intake.

## Technologies
- Java
- JSP
- HTML and CSS
- JavaScript
- MySQL
- JDBC
- Apache Tomcat

## Features
- Enter a person's name, date, and glasses of water
- Validate water intake between 0 and 20 glasses
- Store records in MySQL
- Display all water intake records
- Calculate average water intake

## Requirements
- JDK
- Apache Tomcat 10
- MySQL
- MySQL Connector/J

## Database Setup
1. Start MySQL.
2. Open phpMyAdmin.
3. Import `database.sql`.

## Run the Project
1. Deploy the `src/main/webapp` folder as `WaterIntakeLog` in Tomcat's `webapps` directory.
2. Ensure the MySQL Connector/J JAR is inside `WEB-INF/lib`.
3. Configure the database URL, username, and password in `result.jsp`.
4. Start Tomcat.
5. Open http://localhost:8080/WaterIntakeLog/

## Author
Name: Mayur Patil
Roll No: MCA-46
Task Number: Task 46: Water Intake Log
