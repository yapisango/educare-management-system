# ADR-002 — Multi-Tenant SaaS Architecture

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

EduCare is designed as a Software-as-a-Service (SaaS) platform intended to serve multiple independent educational institutions from a single application.

Rather than developing separate software installations for each school, the platform will host multiple schools within the same system while ensuring complete logical separation of their data.

Each school operates as an independent tenant with its own users, learners, academic structure, and operational data.

This architectural decision supports long-term scalability while reducing deployment, maintenance, and operational costs.

---

# Decision

EduCare will adopt a **Multi-Tenant SaaS Architecture**.

Every business entity within the system will belong to a single School.

The **School** entity acts as the root of the business domain and establishes the ownership boundary for all application data.

Examples include:

- Academic Years
- Grades
- Sections
- Users
- Teachers
- Learners
- Guardians
- Enrolments
- Attendance
- Assessments
- Reports

Every query, service, and business operation must execute within the context of a single School.

---

# Rationale

Schools are independent organisations.

Although they perform similar business processes, they must never share operational data.

Using a multi-tenant architecture provides several advantages:

- One application serves many schools.
- New schools can be onboarded quickly.
- Maintenance is centralised.
- Feature updates benefit every tenant.
- Infrastructure costs are significantly reduced.
- The platform can scale as the customer base grows.

By establishing tenant boundaries at the architectural level, data isolation becomes a fundamental property of the system rather than an implementation detail.

---

# Consequences

## Positive

- Supports unlimited schools within one platform.
- Simplifies deployment and maintenance.
- Reduces infrastructure costs.
- Provides consistent functionality across all tenants.
- Enables future subscription-based licensing.
- Establishes a scalable foundation for SaaS growth.

## Trade-offs

- Every business operation must be tenant-aware.
- Additional validation is required to prevent cross-tenant access.
- Database queries must consistently filter by School.
- Authentication and authorisation become tenant-sensitive.

These trade-offs are acceptable because they provide strong data isolation and long-term scalability.

---

# Design Principles

The following rules apply throughout the platform:

- Every tenant is represented by a School.
- Every business entity belongs to exactly one School.
- Cross-school data access is prohibited.
- Business services execute within a tenant context.
- Reports are generated only from tenant-owned data.
- User permissions are evaluated within the tenant boundary.

---

# Example

Instead of separate databases for each school:

```
School A Database

School B Database

School C Database
```

EduCare uses a shared application with logical tenant separation:

```
EduCare Platform

│

├── School A
│     ├── Learners
│     ├── Teachers
│     ├── Attendance
│     └── Reports
│
├── School B
│     ├── Learners
│     ├── Teachers
│     ├── Attendance
│     └── Reports
│
└── School C
      ├── Learners
      ├── Teachers
      ├── Attendance
      └── Reports
```

Each school experiences the platform as though it were its own dedicated system while sharing the same application infrastructure.

---

# Related ADRs

This decision builds upon:

- ADR-001 — Domain-Driven Business Modelling

This decision directly influences:

- ADR-004 — School Entity Design
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

This ADR directly supports:

- YEP-001 — Model the Business, Not the Screen
- YEP-005 — Engineer for Change
- YEP-006 — Multi-Tenant by Design
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

Multi-tenancy is not a deployment strategy—it is a core architectural decision.

By making the School the root of the business domain and enforcing tenant boundaries throughout the application, EduCare is designed to scale from a single school to thousands of independent educational institutions without fundamental architectural changes.

Every future feature should preserve tenant isolation while maintaining a consistent experience across all schools.