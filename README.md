# BookFlow — Online Library Management System

Role-based Online Library Management System built with Spring Boot, Spring MVC + JSP,
Spring Security, Hibernate/JPA, and MySQL.

**Project Lead:** Mayank Prashar
**Type:** Academic Full-Stack Project · 12 Weeks

## Tech Stack

- **Backend:** Java 17, Spring Boot 3.2.5, Spring MVC, Spring Security, Hibernate/JPA
- **Frontend:** JSP + JSTL, Tailwind CSS, JavaScript ES6+ (AJAX)
- **Database:** MySQL 8, HikariCP connection pool
- **APIs:** Gemini API (AI recommendations), iText 7 (PDF), Apache Commons CSV (CSV export)
- **Build:** Maven · **Server:** Apache Tomcat (embedded for dev, external for deploy)

## Project Structure

```
src/main/java/com/bookflow/
├── BookflowApplication.java     Main entry point
├── config/                      SecurityConfig, AppConfig (beans)
├── controller/                  Auth, Dashboard, Admin, Librarian, Student
├── dto/                         Request payloads (Registration, Book, Issue, Return)
├── exception/                   BookFlowException (single source — don't duplicate)
├── model/                       JPA entities (9 tables)
├── repository/                  Spring Data JPA repositories
├── security/                    UserDetails + UserDetailsService
├── service/                     Business logic layer
└── util/                        SystemIdGenerator, PasswordPolicy, Pdf/Csv exporters

src/main/resources/
├── application.properties       DB, JSP, security, Gemini config
├── schema.sql                   Run once to create DB + all 9 tables
└── static/                      css/js/images (served at /css, /js, /images)

src/main/webapp/WEB-INF/views/   JSP files (admin/, librarian/, student/, auth/, common/)
```

## Setup

1. **Install MySQL 8** and start the service.

2. **Run the schema:**
   ```bash
   mysql -u root -p < src/main/resources/schema.sql
   ```

3. **Configure credentials** in `src/main/resources/application.properties`:
   ```properties
   spring.datasource.username=root
   spring.datasource.password=YOUR_ACTUAL_PASSWORD
   ```
   (See `mysql.txt` for more notes.)

4. **Set your Gemini API key** (free tier) in the same file:
   ```properties
   bookflow.gemini.api-key=YOUR_GEMINI_KEY
   ```

5. **Create the JSP view folders** if not already present:
   ```bash
   mkdir -p src/main/webapp/WEB-INF/views/{admin,librarian,student,auth,common}
   ```

6. **Build and run:**
   ```bash
   mvn clean compile
   mvn spring-boot:run
   ```
   App runs at `http://localhost:8080/bookflow`

## System ID Format

`FIRSTNAME + 6-DIGIT-RANDOM + ROLECODE`, e.g. `PRIYA095312STU`

| Role | Code | Password Rule |
|---|---|---|
| Admin | ADM | 8+ chars, 1 uppercase, 1 special char |
| Librarian | LIB | 8+ chars, 1 uppercase, 1 number |
| Student | STU | 6+ chars, 1 number |

## Route Map

| Path | Access | Purpose |
|---|---|---|
| `/auth/login`, `/auth/register` | Public | Authentication |
| `/admin/**` | ROLE_ADM | Dashboard, book/user mgmt, reports |
| `/librarian/**` | ROLE_LIB, ROLE_ADM | Issue/return, fines, reservations |
| `/student/**` | ROLE_STU | Dashboard, catalogue, fines, AI recs |

## Notes

- `spring.jpa.hibernate.ddl-auto=update` is set, so Hibernate will also sync
  entity changes automatically — but `schema.sql` should be run first since it
  seeds default config rows (fine rates, borrow limits).
- Cover images and uploads are stored under `uploads/covers/` (gitignored).
- Gemini recommendations cache for 24h per student in the `ai_cache` table;
  falls back to top-borrowed books if the API is unreachable.