# ADR-004 — School Entity Design

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

EduCare is designed as a multi-tenant Software-as-a-Service (SaaS) platform where multiple independent educational institutions share the same application.

Each institution operates independently and owns its own users, academic structure, learners, teachers, guardians, attendance records, and reports.

To establish clear ownership boundaries throughout the platform, the system requires a root business entity that represents each educational institution.

---

# Decision

The **School** entity will serve as the root entity of the EduCare business domain.

Every major business entity within the platform will belong to exactly one School, either directly or indirectly through its relationships.

The School establishes the tenant boundary and ownership context for all business operations.

---

# Rationale

A school is the highest-level business concept within EduCare.

Without a School there can be:

- no Academic Years
- no Grades
- no Sections
- no Learners
- no Teachers
- no Guardians
- no Attendance
- no Reports

By making School the root entity, every record can be traced back to its owning institution.

This simplifies:

- security
- reporting
- tenant isolation
- auditing
- future scaling

---

# Entity Responsibilities

The School entity is responsible for representing an educational institution.

Typical information includes:

- School Name
- EMIS Number (where applicable)
- Registration Number
- School Type
- Contact Details
- Physical Address
- Province
- Country
- Operational Status

The School entity does **not** contain academic or operational data.

Instead, it owns the entities that manage those concerns.

---

# Business Relationships

The School owns:

- Academic Years
- Users
- Roles
- Teachers
- Learners
- Guardians
- Grades
- Sections
- Enrolments
- Attendance
- Assessments
- Reports

This creates a clear ownership hierarchy throughout the system.

---

# Domain Model

```
School
│
├── Academic Years
│
├── Users
│
├── Roles
│
├── Grades
│
├── Sections
│
├── Learners
│
├── Guardians
│
├── Teachers
│
├── Enrolments
│
├── Attendance
│
└── Reports
```

Every business entity ultimately belongs to a School.

---

# Consequences

## Positive

- Clear ownership boundaries.
- Supports multi-tenancy naturally.
- Simplifies security implementation.
- Improves reporting.
- Enables scalable SaaS architecture.
- Establishes a consistent business hierarchy.

## Trade-offs

- Every major entity requires either a direct or indirect relationship to School.
- Queries must operate within a tenant context.
- Database relationships become more explicit.

These trade-offs improve consistency and long-term maintainability.

---

# Design Principles

The following rules apply:

- Every School is an independent tenant.
- Schools cannot access one another's information.
- Business operations execute within the context of a School.
- Deleting a School should be highly restricted due to its ownership of critical business data.
- Historical records remain associated with their School.

---

# Future Expansion

The School entity has been designed to support future capabilities, including:

- Multiple campuses
- School branding
- Subscription plans
- Licensing
- Billing
- Regional settings
- Academic policies
- Custom grading systems
- Feature configuration

These capabilities can be added without redesigning the core architecture.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-002 — Multi-Tenant SaaS Architecture
- ADR-003 — Event-Driven Business Architecture

Influences:

- ADR-005 — User Entity Design
- ADR-006 — Role-Based Access Control Model
- ADR-007 — Academic Year Entity Design
- ADR-008 — Grade Entity Design
- ADR-009 — Section Entity Design
- ADR-010 — Learner Entity Design
- ADR-011 — Guardian Relationship Model
- ADR-012 — Enrolment Entity Design
- ADR-013 — Attendance Event Model

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-001 — Model the Business, Not the Screen
- YEP-005 — Engineer for Change
- YEP-006 — Multi-Tenant by Design
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

The School entity is the cornerstone of the EduCare domain model.

It is more than a database table—it represents the organisational boundary within which every business process takes place.

Every future feature should begin by asking:

> **"Which School owns this information?"**

Answering that question correctly ensures that the platform remains secure, scalable, and true to its multi-tenant architecture.