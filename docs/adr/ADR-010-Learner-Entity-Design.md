# ADR-010 — Learner Entity Design

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

The Learner is the central participant within the educational domain.

Throughout their educational journey, a learner may:

- enrol in multiple Academic Years
- move between Sections
- change Guardians
- attend classes
- complete assessments
- receive reports
- graduate

Although these activities change over time, the learner remains the same individual.

EduCare therefore requires the Learner to represent a stable business identity while educational activities are modelled separately.

---

# Decision

EduCare will model **Learner** as an independent business entity.

The Learner represents the permanent identity of a student within a School.

Academic participation, class placement, attendance, assessments and progression will be represented through separate business entities and historical events.

The Learner itself should contain only information that describes the individual.

---

# Rationale

A learner's educational journey changes continuously.

Examples include:

- changing Grade each year
- moving between Sections
- changing Guardians
- transferring schools
- repeating a Grade
- graduating

These changes should never require replacing or recreating the Learner.

Instead, they become historical records linked to a single learner identity.

This preserves continuity throughout the learner's educational life.

---

# Entity Responsibilities

The Learner entity represents the identity of a student.

Typical information includes:

- Admission Number
- First Name
- Last Name
- Date of Birth
- Gender
- National Identification Number (where applicable)
- Profile Photo
- Date Joined School
- Current Status
- School

The Learner does **not** contain:

- Grade
- Section
- Attendance
- Assessment Results
- Guardian Assignments
- Academic Progress

These are represented through related entities.

---

# Business Relationships

A Learner belongs to one School.

A Learner may have:

- Many Enrolments
- Many Attendance Records
- Many Assessments
- Many Guardian Relationships
- Many Reports
- Many Behaviour Records (future)

The Learner remains the permanent identity throughout these relationships.

---

# Domain Model

```
School
    │
    ▼
Learner
    │
    ├── Enrolments
    ├── Attendance
    ├── Assessments
    ├── Guardian Relationships
    ├── Reports
    └── Behaviour Records
```

The Learner is the centre of the educational journey.

The surrounding entities describe that journey over time.

---

# Consequences

## Positive

- Preserves learner identity.
- Eliminates duplicated learner records.
- Supports complete educational history.
- Simplifies reporting.
- Enables long-term analytics.
- Supports future integrations.

## Trade-offs

- Requires multiple related entities.
- Current learner information is derived from relationships rather than stored directly.
- Reporting requires joining historical records.

These trade-offs provide significantly greater flexibility and preserve the integrity of the learner's history.

---

# Design Principles

The following rules apply:

- Every Learner belongs to one School.
- Learners are never recreated when academic circumstances change.
- Learners may have multiple Enrolments over time.
- Learners may have multiple Guardian relationships.
- Historical information is preserved.
- Learners should rarely be deleted.

---

# Future Expansion

The Learner entity has been designed to support future capabilities including:

- Learner Portal
- Medical Information
- Emergency Contacts
- Behaviour Tracking
- Awards and Achievements
- Extracurricular Activities
- Transport Management
- Hostel Management
- Alumni Records

These capabilities can be introduced without redesigning the Learner entity.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-003 — Event-Driven Business Architecture
- ADR-004 — School Entity Design
- ADR-007 — Academic Year Entity Design
- ADR-008 — Grade Entity Design
- ADR-009 — Section Entity Design

Supports:

- ADR-011 — Guardian Relationship Model
- ADR-012 — Enrolment Entity Design
- ADR-013 — Attendance Event Model

Future entities such as Assessments, Reports, Behaviour Records and Fee Payments will also reference the Learner.

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

The Learner represents **identity**, not **academic placement**.

A learner should never "become Grade 7."

Instead:

- the Learner remains constant
- an Enrolment records participation in Grade 7
- Attendance records daily participation
- Assessments record academic performance

This separation preserves the learner's complete educational history while allowing the academic structure to evolve independently.

When designing future features, ask:

> "Does this describe the learner, or does it describe something that happened to the learner?"

If it describes something that happened, it belongs in a separate business entity or event rather than the Learner itself.