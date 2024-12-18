# Student Management System

A Java web application for managing student and class information.

## Prerequisites

- Java JDK 11 or higher
- MySQL 8.0 or higher
- Apache Tomcat 10.0 or higher
- Maven 3.6 or higher

## Project Setup

1. Clone the repository
2. Create the database using the SQL script in `src/main/resources/database/init.sql`
3. Update database connection settings in `DBConnection.java` if needed
4. Build the project using Maven:
   ```bash
   mvn clean install
   ```
5. Deploy the WAR file to Tomcat

## Database Configuration

The default database configuration is:
- URL: jdbc:mysql://localhost:3306/student_management
- Username: root
- Password: (empty)

To change these settings, modify the constants in `DBConnection.java`

## Features

- Class Management
  - Add new classes with sections
  - List all classes with student counts
  - Delete classes (prevented if students are enrolled)
  - Update class information

## Project Structure

```
StudentManagementSystem/
├── src/
│   └── main/
│       ├── java/
│       │   └── StudentManagementSystem/
│       │       ├── Controller/    # Servlet controllers
│       │       ├── DAO/          # Data Access Objects
│       │       └── Model/        # Entity classes
│       ├── resources/
│       │   └── database/        # SQL scripts
│       └── webapp/
│           └── WEB-INF/         # Web resources
└── pom.xml                      # Maven configuration
```

## Dependencies

- Jakarta EE 9.1
- MySQL Connector/J
- GSON
- Bootstrap 5 (frontend)

## Error Handling

The application includes comprehensive error handling:
- Database connection errors
- Duplicate class prevention
- Student enrollment checks before class deletion
- Input validation
