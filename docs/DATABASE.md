# EduCare Management System

# Database Design

**Version:** 1.0  
**Status:** Living Document  
**Last Updated:** July 2026

---

# 1. Overview

The EduCare Management System uses a relational database designed to support a scalable, secure, and multi-tenant Software-as-a-Service (SaaS) platform.

The database has been normalised to reduce redundancy while maintaining high performance and ensuring data integrity.

The design follows established software engineering principles including:

- Third Normal Form (3NF)
- Referential Integrity
- ACID Transactions
- Domain-Driven Design (DDD)
- Multi-Tenant Architecture
- Soft Delete Strategy
- Auditability

---

# 2. Database Technology

Current Database

- PostgreSQL

Reasons for selection:

- Open Source
- Excellent reliability
- Strong transaction support
- Advanced indexing
- JSON support
- High scalability
- Mature ecosystem

Future versions may support managed PostgreSQL cloud services.

---

# 3. Database Design Principles

The database has been designed using the following principles:

- One source of truth
- Minimal redundancy
- Referential integrity
- Strong relationships
- Easy maintenance
- Predictable naming conventions
- High query performance
- Future scalability

---

# 4. Multi-Tenant Architecture

EduCare supports multiple schools using a shared database.

Each business record contains a tenant identifier.

Example

```
school_id
```

This ensures that:

- Schools only access their own data.
- Queries remain isolated.
- Security is maintained.
- Scaling is simplified.

---

# 5. Core Database Domains

The system is organised into several business domains.

## Organisation

- Schools
- Branches (future)
- Campuses (future)

---

## Identity

- Users
- Roles
- Permissions

---

## Academic

- Academic Years
- Grades
- Sections
- Subjects
- Timetables

---

## Learner Management

- Learners
- Guardians
- Enrolments
- Attendance
- Assessments

---

## Finance

- Fees
- Payments
- Invoices
- Discounts

---

## Communication

- Notifications
- Messages
- Announcements

---

## Administration

- Audit Logs
- Settings
- Documents

---

# 6. Primary Entities

The major entities in the database include:

| Entity | Purpose |
|---------|----------|
| Schools | Tenant information |
| Users | Login accounts |
| Roles | Access permissions |
| Learners | Student records |
| Guardians | Parent information |
| AcademicYears | Academic calendar |
| Grades | Grade levels |
| Sections | Individual classes |
| Enrolments | Learner registration |
| Attendance | Daily attendance |
| Assessments | Examination records |
| Payments | Financial records |
| Notifications | Communication logs |

---

# 7. Entity Relationships

Typical relationships include:

School

↓

Users

↓

Roles

↓

Learners

↓

Enrolments

↓

Grades

↓

Sections

↓

Attendance

↓

Assessments

↓

Reports

All entities maintain referential integrity using foreign keys.

---

# 8. Naming Conventions

Tables use plural nouns.

Examples

```
schools
users
learners
guardians
attendance
payments
```

Primary keys

```
id
```

Foreign keys

```
school_id
guardian_id
learner_id
grade_id
section_id
user_id
```

Boolean values

```
is_active
is_deleted
email_verified
```

Date fields

```
created_at
updated_at
deleted_at
```

---

# 9. Primary Keys

Each table uses a single primary key.

Example

```
id
```

Future versions may migrate to UUIDs for distributed systems.

---

# 10. Foreign Keys

Relationships are enforced through foreign keys.

Example

```
learners.school_id

→ schools.id
```

```
attendance.learner_id

→ learners.id
```

```
payments.guardian_id

→ guardians.id
```

---

# 11. Data Integrity

Integrity is maintained using:

- Primary Keys
- Foreign Keys
- NOT NULL constraints
- UNIQUE constraints
- CHECK constraints
- Transactions

These ensure the database remains consistent even during failures.

---

# 12. Normalisation

The database follows Third Normal Form (3NF).

Benefits include:

- Reduced redundancy
- Easier maintenance
- Better consistency
- Lower storage requirements

Certain reporting tables may be denormalised in future to improve analytics performance.

---

# 13. Indexing Strategy

Indexes improve query performance.

Typical indexed columns include:

- school_id
- learner_number
- email
- username
- created_at
- academic_year_id
- section_id

Composite indexes will be introduced as reporting requirements grow.

---

# 14. Soft Delete Strategy

Records are not immediately removed.

Instead they contain:

```
deleted_at
```

or

```
is_deleted
```

Benefits include:

- Recovery of accidental deletions
- Audit history
- Regulatory compliance

---

# 15. Audit Fields

Every business table should include:

```
created_at
updated_at
created_by
updated_by
```

Future versions may include:

```
deleted_by
deleted_at
```

---

# 16. Transactions

Critical operations execute inside database transactions.

Examples:

- Learner enrolment
- Payment processing
- Fee generation
- User creation

This guarantees database consistency.

---

# 17. Security

Sensitive data is protected using:

- Password hashing
- Encrypted connections
- Least privilege database users
- Prepared statements
- Input validation

No passwords are stored in plain text.

---

# 18. Backup Strategy

Recommended backup policy:

Daily incremental backups

Weekly full backups

Monthly archive snapshots

Disaster recovery testing every quarter.

---

# 19. Future Database Enhancements

Planned improvements include:

- UUID primary keys
- Database partitioning
- Read replicas
- Materialised views
- Reporting warehouse
- Event sourcing support
- AI analytics tables

---

# 20. Database Standards

All database development follows the YapiTech Engineering Handbook.

Key standards include:

- Consistent naming
- Referential integrity
- Strong documentation
- Migration-first development
- Code review before schema changes

---

# Document Status

This document evolves alongside the EduCare Management System and should be updated whenever the database schema changes or new business domains are introduced.

-- =============================================================================
--users
│
├── learners
│      │
│      ├── emergency_contacts
│      │
│      └── guardian_learners
│              │
│              ▼
│         guardians
│
├── teachers
│
├── staff
│
├── user_sessions
│
└── password_reset_tokens
--
-- =============================================================================

School
│
├── Subjects
│
├── Teachers
│      │
│      └── Teacher Subjects
│
├── Classes
│      │
│      └── Class Subjects
│
└── Academic Year

Attendance Session
│
├── School
├── Academic Year
├── Term
├── Class
├── Subject
├── Teacher
│
└── Attendance Entries
        │
        ├── Learner
        ├── Status
        ├── Reason
        └── Recorded Time

        Assessment
│
├── School
├── Academic Year
├── Term
├── Class
├── Subject
├── Teacher
│
└── Assessment Results
        │
        ├── Learner
        ├── Marks
        ├── Percentage
        └── Grade


Report Card
│
└── Report Card Items
        │
        ├── Subject
        ├── Final Mark
        ├── Percentage
        └── Grade

        Announcement
│
├── School
└── Everyone


Notification
│
└── One User


Message
│
├── Sender
│
└── Message Recipients
        │
        ├── User 1
        ├── User 2
        ├── User 3
        └── User N

Operational Tables
│
├── Learners
├── Teachers
├── Attendance
├── Assessments
├── Classes
│
▼

Summary Tables
│
├── Dashboard Statistics
├── Attendance Summary
└── Academic Performance Summary
│
▼

SQL Views
│
├── vw_school_dashboard
├── vw_learner_attendance
├── vw_teacher_performance
└── vw_subject_results
│
▼

Dashboards
Reports
Charts
Analytics
Power BI

Users
│
├── Roles
│       │
│       └── Role Permission
│               │
│               ▼
│          Permissions
│
├── Audit Logs
│
└── System Settings
