# ADR-011 — Guardian Relationship Model

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Learners are supported by a wide variety of family and care structures.

While many learners have biological parents, others may be cared for by:

- Grandparents
- Aunts or Uncles
- Foster Parents
- Legal Guardians
- Siblings
- Social Workers
- Caregivers
- Children's Homes

A learner may also have multiple guardians with different responsibilities.

Traditional school systems often model only "Father" and "Mother", which does not accurately represent modern family structures.

EduCare requires a flexible relationship model capable of representing any legally or practically responsible adult.

---

# Decision

EduCare will model Guardians through a dedicated **Guardian Relationship** entity.

A Guardian exists independently.

The relationship between a Learner and a Guardian is modelled separately.

This allows:

- one learner to have many guardians
- one guardian to care for many learners
- different types of guardian relationships
- historical tracking of relationship changes

---

# Rationale

The person is not the relationship.

For example:

A grandmother remains the same person regardless of how many grandchildren she cares for.

Likewise, a learner may gain or lose guardians over time without changing their own identity.

By separating Guardian from Guardian Relationship, EduCare accurately models real family structures while preserving history.

---

# Entity Responsibilities

The Guardian Relationship represents the connection between a Learner and a Guardian.

Typical information includes:

- Learner
- Guardian
- Relationship Type
- Primary Contact
- Emergency Contact
- Financial Responsibility
- Legal Guardian
- Pickup Authorisation
- Effective Date
- End Date (optional)
- Status

The relationship stores responsibilities rather than personal information.

---

# Relationship Types

Examples include:

- Mother
- Father
- Grandmother
- Grandfather
- Aunt
- Uncle
- Sister
- Brother
- Foster Parent
- Legal Guardian
- Social Worker
- Caregiver
- Other

Relationship types may be extended without changing the database structure.

---

# Business Relationships

Each Guardian Relationship connects:

```
Learner
        │
        ▼
Guardian Relationship
        ▲
        │
Guardian
```

A learner may have many Guardian Relationships.

A Guardian may support many Learners.

---

# Domain Model

```
School
    │
    ▼
Learner
    │
    ├── Guardian Relationship
    │         │
    │         ▼
    │     Guardian
```

The relationship represents responsibility.

The Guardian represents the person.

---

# Consequences

## Positive

- Supports modern family structures.
- Eliminates duplicated guardian information.
- Preserves historical relationships.
- Supports siblings sharing the same guardian.
- Allows multiple emergency contacts.
- Improves reporting.
- Reflects real-world educational administration.

## Trade-offs

- Requires an additional relationship entity.
- Relationship management becomes more sophisticated.
- More joins are required when retrieving guardian information.

These trade-offs are acceptable because they produce a significantly more accurate business model.

---

# Design Principles

The following rules apply:

- Guardians exist independently of Learners.
- Learners may have multiple Guardians.
- Guardians may support multiple Learners.
- Responsibilities belong to the relationship.
- Historical Guardian Relationships should be preserved.
- Relationship types should remain configurable.

---

# Future Expansion

The Guardian Relationship model has been designed to support future capabilities including:

- Parent Portal
- Fee Responsibility
- Digital Consent
- Medical Consent
- Pickup Verification
- Emergency Notifications
- Communication Preferences
- Court Orders
- Custody Arrangements

These capabilities can be introduced without redesigning the relationship model.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-003 — Event-Driven Business Architecture
- ADR-010 — Learner Entity Design

Supports future ADRs covering:

- Parent Portal
- Communication
- School Fees
- Medical Records
- Emergency Management

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-001 — Model the Business, Not the Screen
- YEP-002 — Separate Identity from State
- YEP-003 — Preserve History
- YEP-004 — Avoid Duplication
- YEP-005 — Engineer for Change
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

The Guardian Relationship represents one of the strongest examples of business-first modelling within EduCare.

Rather than assuming every learner has a mother and father, the platform models responsibility as a relationship between two independent people.

This allows EduCare to support the diverse family structures found in modern educational communities while preserving flexibility, historical accuracy, and future extensibility.

Whenever family requirements evolve, new relationship types or responsibilities can be added without changing the underlying architecture.

This decision embodies one of YapiTech's core engineering beliefs:

> **Software should model the real world—not simplify it until it no longer reflects reality.**