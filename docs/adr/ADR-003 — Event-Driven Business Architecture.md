# ADR-003 — Event-Driven Business Architecture

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Educational institutions are dynamic organisations.

Learners enrol, transfer, graduate, change guardians, attend classes, receive assessments, and participate in many activities throughout their academic journey.

Traditional information systems often represent only the current state of the business by updating existing records whenever changes occur.

While this simplifies implementation, it destroys historical information and limits reporting, auditing, and future business capabilities.

EduCare aims to preserve the complete educational journey rather than only the latest state.

---

# Decision

EduCare will adopt an **Event-Driven Business Architecture**.

Important business activities will be recorded as immutable business events rather than simply updating existing records.

Business entities represent identity.

Business events represent change over time.

Whenever possible, the system will create new historical records instead of overwriting previous information.

---

# Rationale

People remain the same.

Their circumstances change.

For example:

- A learner does not become a different learner because they change grades.
- A guardian relationship may change over time.
- Attendance occurs every school day.
- Enrolments happen at specific points in time.
- Assessments occur throughout an academic year.

These are events, not permanent properties.

Recording them as historical events preserves the complete operational history of the school.

---

# Event Examples

Instead of updating a learner record repeatedly:

```
Learner

Grade = 5

↓

UPDATE

Grade = 6
```

EduCare records:

```
Learner

↓

Enrolment Event

↓

Attendance Event

↓

Assessment Event

↓

Promotion Event

↓

Graduation Event
```

The learner remains the same person.

The events describe their educational journey.

---

# Business Benefits

Recording business events enables:

- Complete audit history
- Historical reporting
- Regulatory compliance
- Academic progression tracking
- Accurate attendance history
- Guardian history
- Future analytics
- Predictive reporting

History becomes a business asset rather than being lost through updates.

---

# Consequences

## Positive

- Historical data is preserved.
- Business processes become traceable.
- Reports can analyse trends over time.
- Future features become easier to implement.
- The system accurately reflects real-world educational processes.

## Trade-offs

- More tables are required.
- Additional relationships must be maintained.
- Business logic becomes more sophisticated.
- Reporting queries may require joining multiple event tables.

These trade-offs are acceptable because they significantly improve long-term flexibility and business intelligence.

---

# Design Principles

The following guidelines apply:

- Identities should rarely be deleted.
- Events should never be overwritten.
- New business activities create new records.
- Historical information should remain available.
- Current state can be derived from historical events when necessary.

---

# Examples within EduCare

Business entities include:

- School
- User
- Learner
- Guardian
- Teacher
- Grade
- Section

Business events include:

- Enrolment
- Attendance
- Assessment
- Fee Payment
- Guardian Assignment
- Class Transfer
- Promotion
- Graduation

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-002 — Multi-Tenant SaaS Architecture

Influences:

- ADR-011 — Guardian Relationship Model
- ADR-012 — Enrolment Entity Design
- ADR-013 — Attendance Event Model

Future ADRs covering assessments, payments, behaviour, promotions, and graduations should also follow this architectural decision.

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-002 — Separate Identity from State
- YEP-003 — Preserve History
- YEP-005 — Engineer for Change
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

This ADR establishes one of the defining architectural characteristics of EduCare.

Rather than viewing the system as a collection of database tables, EduCare models the educational journey as a sequence of business events occurring over time.

This approach preserves history, improves reporting, supports auditing, and creates a platform that can evolve with changing educational requirements without sacrificing historical accuracy.

Every future feature should ask one fundamental question:

> "Is this a permanent business entity, or is it a business event?"

The answer determines how it should be modelled.