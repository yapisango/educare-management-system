# EduCare Management System

# Database Blueprint

**Version:** 1.0  
**Status:** Living Document  
**Last Updated:** July 2026

---

# 1. Purpose

The Database Blueprint defines the business domains, entities, relationships, and ownership of data before implementation begins.

Unlike `schema.sql`, this document is technology-independent.

Its purpose is to ensure that the database accurately models the business before any SQL is written.

This blueprint acts as the bridge between business analysis and database implementation.

---

# 2. Engineering Philosophy

At YapiTech, we believe that databases should model businesses—not tables.

Rather than beginning with SQL, we first understand the business domains, identify the entities within each domain, define how they interact, and only then implement the physical database.

Engineering Process

Business Idea

↓

Business Domains

↓

Business Blueprint

↓

Database Blueprint

↓

Database Schema

↓

Backend

↓

Frontend

---

# 3. Business Domains

EduCare consists of the following business domains.

| Domain | Purpose |
|---------|----------|
| School | School information and configuration |
| Identity | Users, authentication and permissions |
| Academic | Grades, classes, subjects and academic years |
| Learner | Learners, guardians and enrolments |
| Staff | Teachers and school employees |
| Attendance | Attendance tracking |
| Assessment | Marks, examinations and report cards |
| Finance | Fees, invoices and payments |
| Communication | Messages, notifications and announcements |
| Reporting | Analytics and reporting |
| System | Audit logs, settings and system configuration |

---

# 4. Domain Ownership

Each domain owns its own data.

```
School Domain

owns

Schools
Academic Years
Terms
Campuses
```

```
Identity Domain

owns

Users
Roles
Permissions
Sessions
```

```
Learner Domain

owns

Learners
Guardians
Emergency Contacts
Enrolments
```

```
Finance Domain

owns

Invoices
Payments
Fee Structures
Discounts
```

No two domains should own the same business concept.

---

# 5. Domain Relationships

```
School

│

├── Identity

├── Academic

├── Learners

├── Staff

├── Finance

├── Communication

└── Reporting
```

The School domain acts as the root of the business.

---

# 6. Domain Breakdown

---

## School Domain

Purpose

Represents each educational institution using EduCare.

Entities

- School
- Campus
- Academic Year
- Term
- School Settings

Relationships

School

↓

Academic Years

↓

Terms

---

## Identity Domain

Purpose

Controls authentication and authorisation.

Entities

- User
- Role
- Permission
- Session

Relationships

User

↓

Role

↓

Permissions

---

## Academic Domain

Purpose

Defines the academic structure.

Entities

- Grade
- Section
- Subject
- Timetable

Relationships

Academic Year

↓

Grade

↓

Section

↓

Subject

---

## Learner Domain

Purpose

Stores learner information.

Entities

- Learner
- Guardian
- Enrolment
- Medical Information

Relationships

Guardian

↓

Learner

↓

Enrolment

↓

Section

---

## Staff Domain

Purpose

Stores employee information.

Entities

- Teacher
- Administrator
- Staff Position

Relationships

Teacher

↓

Subjects

↓

Sections

---

## Attendance Domain

Purpose

Tracks learner attendance.

Entities

- Attendance
- Attendance Status

Relationships

Learner

↓

Attendance

---

## Assessment Domain

Purpose

Records learner performance.

Entities

- Assessment
- Marks
- Report Cards

Relationships

Subject

↓

Assessment

↓

Learner Marks

---

## Finance Domain

Purpose

Handles school billing.

Entities

- Fee Structure
- Invoice
- Payment
- Discount

Relationships

Learner

↓

Invoice

↓

Payment

---

## Communication Domain

Purpose

Supports communication.

Entities

- Announcement
- Notification
- Message

Relationships

User

↓

Notification

---

## Reporting Domain

Purpose

Provides analytics.

Entities

- Attendance Reports
- Financial Reports
- Academic Reports

---

## System Domain

Purpose

Supports platform administration.

Entities

- Audit Logs
- Settings
- Configuration

---

# 7. Cross-Domain Rules

Examples

A learner cannot exist without belonging to a school.

An enrolment cannot exist without a learner.

Payments belong to invoices.

Assessments belong to subjects.

Teachers belong to schools.

These business rules drive database design.

---

# 8. Future Domains

The architecture allows additional domains without restructuring existing ones.

Examples

- Library
- Hostel
- Transport
- Sports
- Healthcare
- Alumni

---

# 9. Transition to schema.sql

Only after this blueprint has been approved do we begin writing SQL.

Each business entity becomes one or more database tables.

Example

Business Entity

Learner

↓

Database Table

learners

Business Entity

Guardian

↓

Database Table

guardians

Business Entity

Invoice

↓

Database Table

invoices

---

# 10. Guiding Principle

> Model the business first.
>
> Model the database second.
>
> Write SQL last.

This principle ensures that the database reflects real business processes rather than technical assumptions.

---

# Document Status

This blueprint evolves whenever new business domains or entities are introduced. All database implementation must remain aligned with this document.