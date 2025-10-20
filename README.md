# Medical Platform

A comprehensive medical management system built with Jakarta EE and Hibernate, designed to manage patients, consultations, and medical expertise requests across different healthcare roles.

## 🏥 Project Overview

This web application provides a complete healthcare management solution with role-based dashboards for different medical staff:
- **Infirmier (Nurse)**: Patient registration and vital signs recording
- **Generaliste (General Practitioner)**: Patient consultations and expertise requests
- **Admin**: System administration

## 🛠️ Technology Stack

### Backend
- **Java 17**
- **Jakarta EE 10** (Servlet API 6.1.0)
- **Hibernate ORM 7.0.4** (JPA Implementation)
- **MySQL Database**
- **Maven** (Build Tool)

### Frontend
- **JSP (JavaServer Pages)**
- **JSTL 3.0** (Jakarta Standard Tag Library)
- **HTML/CSS/JavaScript**

### Security
- **BCrypt** (Password Hashing)
- **CSRF Protection**

### Libraries
- MySQL Connector/J 9.4.0
- JBCrypt 0.4
## 📋 Prerequisites

Before running this application, ensure you have:

- **JDK 17** or higher installed
- **Apache Tomcat 10.x** or compatible Jakarta EE 10 application server
- **MySQL 8.0** or higher
- **Maven 3.6+** (or use included wrapper scripts)
- **IDE**: IntelliJ IDEA, Eclipse, or NetBeans (recommended for Jakarta EE development)

## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd medical-platform
```

### 2. Database Configuration

1. Start your MySQL server
2. The application will automatically create the database `medicalmanagement` on first run
3. Update database credentials if needed in `src/main/resources/META-INF/persistence.xml`:

```xml
<property name="jakarta.persistence.jdbc.url" value="jdbc:mysql://localhost:3306/medicalmanagement?createDatabaseIfNotExist=true"/>
<property name="jakarta.persistence.jdbc.user" value="root"/>
<property name="jakarta.persistence.jdbc.password" value=""/>
```

### 3. Build the Project
```bash
mvn clean package
```

## 📁 Project Structure

```
medical-platform/
├── src/
│   ├── main/
│   │   ├── java/com/example/medicalplatform/
│   │   │   ├── dao/                 # Data Access Layer
│   │   │   │   ├── impl/            # DAO implementations
│   │   │   │   ├── AuthInterface.java
│   │   │   │   ├── ConsultationInterface.java
│   │   │   │   ├── PatientInterface.java
│   │   │   │   └── ...
│   │   │   ├── enums/               # Enumerations
│   │   │   │   ├── SpecialiteEnum.java
│   │   │   │   ├── StatutConsultation.java
│   │   │   │   └── ...
│   │   │   ├── model/               # JPA Entities
│   │   │   │   ├── Utilisateur.java
│   │   │   │   ├── Patient.java
│   │   │   │   ├── Consultation.java
│   │   │   │   ├── DossierMedical.java
│   │   │   │   └── ...
│   │   │   ├── service/             # Business Logic Layer
│   │   │   │   └── impl/
│   │   │   ├── servlet/             # HTTP Servlets
│   │   │   │   ├── LoginServlet.java
│   │   │   │   ├── RegisterServlet.java
│   │   │   │   ├── InfermierServlet.java
│   │   │   │   ├── GeneralisteServlet.java
│   │   │   │   └── ...
│   │   │   └── utils/               # Utility Classes
│   │   │       ├── EmfUtil.java
│   │   │       └── CsrfValidation.java
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml  # JPA Configuration
│   │   └── webapp/
│   │       ├── auth/                # Authentication Pages
│   │       │   ├── login.jsp
│   │       │   └── register.jsp
│   │       ├── dashboard/           # Role-based Dashboards
│   │       │   ├── infermier/
│   │       │   ├── generaliste/
│   │       │   └── specialiste/
│   │       └── WEB-INF/
│   │           └── web.xml          # Web Application Config
│   └── test/                        # Unit Tests
├── pom.xml                          # Maven Configuration
├── mvnw, mvnw.cmd                   # Maven Wrapper Scripts
└── README.md                        # This file
```

## 🔑 Key Features

### 1. **Authentication & Authorization**
- Secure login/logout with BCrypt password hashing
- Role-based access control (RBAC)
- CSRF token validation
- Session management

### 2. **Nurse (Infirmier) Dashboard**
- Register new patients
- Record vital signs (temperature, blood pressure, heart rate, etc.)
- View patient queue
- Manage patient waiting list

### 3. **General Practitioner Dashboard**
- View patient waiting list
- Conduct consultations
- Record medical observations
- Request specialist expertise
- Manage patient medical records

### 5. **Patient Management**
- Complete patient registration
- Medical history tracking
- Consultation records
- Medical file management

## 🗃️ Database Schema

The application uses Hibernate with JPA annotations for ORM. Key entities include:

- **Utilisateur** (User) - Base user entity with inheritance
  - Admin
  - Infermier (Nurse)
  - Generaliste (General Practitioner)
  - Specialiste (Specialist)
- **Patient** - Patient information and medical records
- **DossierMedical** - Medical file
- **Consultation** - Medical consultations
- **DemandeExpertise** - Expertise requests
- **SignesVitaux** - Vital signs records
- **ActeTechnique** - Technical medical procedures
- **Creneau** - Time slots for appointments

### Main Routes:
- **Login**: `/auth/login.jsp`
- **Register**: `/auth/register.jsp`
- **Nurse Dashboard**: `/dashboard/infermier`
- **GP Dashboard**: `/dashboard/generaliste`
- **Specialist Dashboard**: `/dashboard/specialiste`
- **Logout**: `/logout`

## 🔧 Configuration

### Hibernate Configuration
Located in `src/main/resources/META-INF/persistence.xml`:
- Auto DDL: `update` (automatically updates schema)
- SQL Logging: Enabled for development
- Dialect: MySQL