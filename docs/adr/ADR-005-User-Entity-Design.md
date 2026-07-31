# ADR-005 — User Entity Design

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Every person interacting with EduCare requires an identity within the platform.

These individuals include:

- Principals
- Administrators
- Teachers
- Learners (future portal)
- Guardians (future portal)
- Support Staff

Traditional school systems often create separate database tables for each type of person.

While this may appear straightforward initially, it leads to duplicated information and makes it difficult to manage people whose responsibilities change over time.

EduCare requires a single identity model that supports changing roles throughout a person's relationship with a school.

---

# Decision

EduCare will maintain a single **User** entity representing every authenticated person within the platform.

The User entity represents identity only.

Responsibilities, permissions, and organisational functions are assigned through separate business relationships.

A person remains the same user regardless of how many responsibilities they perform.

---

# Rationale

People rarely perform only one role.

Examples include:

- A teacher later becomes a principal.
- An administrator may also teach classes.
- A principal may temporarily perform administrative duties.
- A future guardian portal user may also become a staff member.

Creating multiple records for the same person introduces unnecessary duplication and increases the risk of inconsistent data.

A single User identity eliminates these problems.

---

# Entity Responsibilities

The User entity is responsible for representing the identity of a person.

Typical information includes:

- First Name
- Last Name
- Email Address
- Mobile Number
- Username
- Password Hash
- Profile Photo
- Account Status
- Last Login
- Created Date

The User entity does **not** determine what a person is allowed to do.

Authorisation is handled separately.

---

# Business Relationships

A User belongs to one School.

A User may have one or more Roles.

Examples include:

- Principal
- Administrator
- Teacher
- Finance Officer
- Librarian
- Learner (future)
- Guardian (future)

Additional business entities may reference a User where appropriate.

---

# Domain Model

```
School
    │
    ▼
User
    │
    ▼
User Role
    │
    ▼
Permissions
```

Identity remains stable.

Responsibilities are assigned through roles.

---

# Consequences

## Positive

- One identity per person.
- Eliminates duplicated personal information.
- Simplifies authentication.
- Supports multiple simultaneous roles.
- Makes future expansion straightforward.
- Reduces maintenance.

## Trade-offs

- Requires an additional relationship between Users and Roles.
- Authorisation logic becomes more sophisticated.
- Role management must be carefully designed.

These trade-offs are acceptable because they create a far more flexible architecture.

---

# Design Principles

The following rules apply:

- Every authenticated person has exactly one User account.
- A User may perform multiple business responsibilities.
- Roles may change without affecting identity.
- Personal information is stored once.
- Authentication is independent of authorisation.

---

# Future Expansion

The User entity has been designed to support future capabilities, including:

- Parent Portal
- Learner Portal
- Teacher Self-Service
- Multi-factor Authentication
- Single Sign-On (SSO)
- Audit Logging
- External Identity Providers
- Profile Preferences

These capabilities can be introduced without redesigning the User model.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-002 — Multi-Tenant SaaS Architecture
- ADR-004 — School Entity Design

Influences:

- ADR-006 — Role-Based Access Control Model

Future business entities referencing people should reference the User entity rather than creating duplicate person records.

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-001 — Model the Business, Not the Screen
- YEP-002 — Separate Identity from State
- YEP-004 — Avoid Duplication
- YEP-005 — Engineer for Change
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

The User entity represents **identity**, not **responsibility**.

A person's identity should remain stable throughout their relationship with the organisation, while their responsibilities evolve over time.

Whenever a new feature requires "another type of person," the first question should be:

> **"Is this a new identity, or simply another role for an existing User?"**

In almost every case, the answer should be another role.

This approach preserves a single source of truth for personal information and ensures the platform remains flexible as schools and responsibilities evolve.