# ADR-014 — Entity Lifecycle and Soft Delete Strategy

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Educational institutions maintain records that often have legal, operational and historical significance.

Examples include:

- Learner enrolments
- Attendance
- Academic reports
- Guardian relationships
- Staff assignments
- Academic years

Deleting these records can result in:

- loss of historical information
- inaccurate reporting
- audit failures
- legal compliance issues
- broken relationships throughout the database

EduCare therefore requires a consistent strategy for managing the lifecycle of business entities.

---

# Decision

EduCare will adopt a **Soft Delete** strategy for all significant business entities.

Business records should rarely be permanently deleted.

Instead, records will transition through defined lifecycle states while preserving historical information.

Deletion is considered an exceptional administrative operation rather than a normal business process.

---

# Rationale

Businesses rarely want information removed permanently.

Instead, they want to know:

- when something became inactive
- why it became inactive
- who performed the action
- whether it can be restored

Soft deletion preserves these answers while maintaining referential integrity throughout the system.

---

# Entity Lifecycle

Most entities follow the same lifecycle.

```
Created
    │
    ▼
Active
    │
    ▼
Inactive
    │
    ▼
Archived
    │
    ▼
Deleted (Exceptional)
```

Not every entity will use every stage, but the lifecycle provides a consistent framework across the platform.

---

# Soft Delete Model

Instead of removing records from the database, entities typically include lifecycle metadata such as:

- Status
- Is Active
- Archived At
- Deleted At
- Deleted By
- Deletion Reason

Applications filter inactive or archived records where appropriate while retaining them for reporting and auditing.

---

# Business Responsibilities

The lifecycle strategy is responsible for:

- preserving historical information
- supporting auditing
- enabling record restoration
- protecting business integrity
- maintaining relationships between entities

It is **not** responsible for enforcing business rules; those remain within the relevant domain entities.

---

# Business Relationships

Lifecycle management applies consistently across the domain.

Examples include:

- School
- Academic Year
- Grade
- Section
- Learner
- Guardian Relationship
- Enrolment
- Attendance
- User
- Roles

Each entity manages its own lifecycle while remaining connected to related records.

---

# Domain Model

```
Business Entity
        │
        ▼
Lifecycle State
        │
        ├── Active
        ├── Inactive
        ├── Archived
        └── Deleted (Exceptional)
```

Every entity remains historically traceable throughout its lifecycle.

---

# Consequences

## Positive

- Preserves complete business history.
- Supports regulatory compliance.
- Improves auditing.
- Prevents accidental data loss.
- Enables restoration of records.
- Maintains referential integrity.
- Supports long-term analytics.

## Trade-offs

- Database size increases over time.
- Queries typically filter inactive records.
- Lifecycle management introduces additional business rules.

These trade-offs are acceptable because preserving historical information is significantly more valuable than reclaiming storage.

---

# Design Principles

The following rules apply:

- Business records should not be permanently deleted during normal operations.
- Historical data should remain available for reporting.
- Lifecycle changes should be auditable.
- Restoration should be supported where appropriate.
- Deletion should require elevated administrative privileges.
- Referential integrity must always be preserved.

---

# Future Expansion

The lifecycle model supports future capabilities including:

- Complete audit trails
- Legal retention policies
- Automated archival
- Record restoration
- Data retention schedules
- Compliance reporting
- Version history
- Event sourcing integration

These capabilities can be introduced without redesigning existing entities.

---

# Related ADRs

Builds upon:

- ADR-003 — Event-Driven Business Architecture
- ADR-004 — School Entity Design
- ADR-010 — Learner Entity Design
- ADR-011 — Guardian Relationship Model
- ADR-012 — Enrolment Entity Design
- ADR-013 — Attendance Event Model

Applies to all significant business entities within EduCare.

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-003 — Preserve History
- YEP-004 — Avoid Duplication
- YEP-005 — Engineer for Change
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

Deleting data should never be the default response to a business change.

Instead, software should record the change while preserving the information that led to it.

A learner who graduates should remain part of the school's history.

An Academic Year that ends should remain available for reporting.

A Guardian Relationship that changes should still explain who was responsible at a particular point in time.

By treating business records as part of an evolving historical timeline rather than disposable data, EduCare provides a more accurate representation of how educational institutions operate.

This decision reinforces one of YapiTech's core engineering beliefs:

> **The past is part of the business. Good software remembers it.**