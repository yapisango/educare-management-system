# ADR-012 — Enrolment Entity Design

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

A learner's placement within a school changes throughout their educational journey.

Each academic year, a learner may:

- enrol in a new Grade
- join a different Section
- repeat a Grade
- transfer to another Section
- leave the school
- re-enrol after an absence

These changes represent business events rather than changes to the learner's identity.

EduCare therefore requires enrolment to be modelled as an independent business entity.

---

# Decision

EduCare will model **Enrolment** as a dedicated business entity.

An Enrolment records a learner's participation in a specific Academic Year and Section.

The Learner remains the permanent identity.

The Enrolment records where and when the learner participates.

Each enrolment represents one academic placement.

---

# Rationale

A learner does not permanently belong to a Grade or Section.

Instead, they participate in a Grade and Section during a particular Academic Year.

Recording this as a separate entity provides:

- complete academic history
- promotion tracking
- transfer history
- repeat-year support
- historical reporting

The learner's identity remains unchanged while enrolments describe their academic journey.

---

# Entity Responsibilities

The Enrolment entity represents academic participation.

Typical information includes:

- Learner
- Academic Year
- Grade
- Section
- Enrolment Date
- Admission Status
- Current Status
- Exit Date (optional)
- Exit Reason (optional)

The Enrolment does **not** store attendance or assessment information.

These reference the Enrolment separately.

---

# Business Relationships

Each Enrolment belongs to:

- One Learner
- One Academic Year
- One Grade
- One Section

An Enrolment may have:

- Many Attendance Records
- Many Assessment Results
- Many Behaviour Records
- Many Report Cards

---

# Domain Model

```
School
    │
    ▼
Learner
    │
    ▼
Enrolment
    │
    ├── Academic Year
    ├── Grade
    ├── Section
    ├── Attendance
    ├── Assessments
    ├── Behaviour
    └── Reports
```

The Enrolment becomes the centre of a learner's academic activity for a particular school year.

---

# Consequences

## Positive

- Preserves complete academic history.
- Supports promotions and repeat years.
- Simplifies transfers between Sections.
- Enables accurate historical reporting.
- Maintains learner identity.
- Supports future analytics.

## Trade-offs

- Introduces an additional business entity.
- Most academic records reference Enrolment rather than Learner directly.
- Queries become slightly more sophisticated.

These trade-offs provide significantly greater historical accuracy and flexibility.

---

# Design Principles

The following rules apply:

- Every Enrolment belongs to one Learner.
- Every Enrolment belongs to one Academic Year.
- Every Enrolment belongs to one Grade.
- Every Enrolment belongs to one Section.
- Learners may have many Enrolments over time.
- Enrolments should never be overwritten.
- Historical Enrolments remain available for reporting.

---

# Future Expansion

The Enrolment entity has been designed to support future capabilities including:

- Promotion workflows
- Transfer history
- Graduation tracking
- Academic progression
- Subject selection
- Curriculum pathways
- Fee billing periods
- Scholarship allocation
- Alumni transition

These capabilities can be introduced without redesigning the enrolment model.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-003 — Event-Driven Business Architecture
- ADR-007 — Academic Year Entity Design
- ADR-008 — Grade Entity Design
- ADR-009 — Section Entity Design
- ADR-010 — Learner Entity Design

Supports:

- ADR-013 — Attendance Event Model

Future entities such as Assessments, Behaviour Records, Report Cards and Fee Billing should reference the Enrolment where they relate to a specific academic year.

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-001 — Model the Business, Not the Screen
- YEP-002 — Separate Identity from State
- YEP-003 — Preserve History
- YEP-005 — Engineer for Change
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

The Enrolment entity represents **participation**, not **identity**.

The learner remains the same individual throughout their education.

Each Enrolment captures one chapter of that learner's academic journey.

This design allows EduCare to answer questions such as:

- Where was this learner enrolled in 2024?
- Which Section did they belong to in 2025?
- How many years did they repeat?
- When did they transfer?
- What was their academic history?

without ever modifying the Learner itself.

Whenever academic placement changes, a new Enrolment records the event while preserving the integrity of the learner's permanent identity.