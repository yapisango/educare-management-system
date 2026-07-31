# ADR-008 — Grade Entity Design

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Educational institutions organise learners into educational levels known as Grades.

A Grade represents a curriculum level within an Academic Year rather than a physical classroom.

Many schools operate multiple Sections within the same Grade.

For example:

- Grade 5
    - Section A
    - Section B
    - Section C

Because class groupings may change from year to year, EduCare requires Grades and Sections to be modelled as separate business entities.

---

# Decision

EduCare will model **Grade** as an independent business entity belonging to an Academic Year.

A Grade represents an academic level only.

Learners are **not** assigned directly to a Grade.

Instead, learners are enrolled into a Section, which belongs to a Grade.

---

# Rationale

Separating Grades from Sections provides significantly greater flexibility.

Schools can:

- create additional Sections when enrolment increases
- merge Sections when enrolment decreases
- rename Sections
- assign different teachers to different Sections

without changing the underlying Grade structure.

This reflects how schools actually operate.

---

# Entity Responsibilities

The Grade entity represents an educational level.

Typical information includes:

- Grade Name
- Grade Code
- Academic Year
- Display Order
- Status

The Grade entity does **not** contain:

- learners
- teachers
- attendance
- enrolments

These belong to related business entities.

---

# Business Relationships

Each Grade belongs to one Academic Year.

Each Grade may contain many Sections.

```
Academic Year
        │
        ▼
     Grade
        │
        ▼
   Section(s)
```

Learners are enrolled into Sections, not directly into Grades.

---

# Domain Model

```
School
    │
    ▼
Academic Year
    │
    ▼
Grade
    │
    ├── Section A
    ├── Section B
    ├── Section C
    └── Section D
```

The Grade defines the educational level.

The Sections organise learners within that level.

---

# Consequences

## Positive

- Supports parallel classes naturally.
- Reflects real school structures.
- Simplifies class expansion.
- Supports future timetable generation.
- Makes reporting more accurate.
- Reduces unnecessary duplication.

## Trade-offs

- Requires an additional Section entity.
- Learner placement becomes a two-step relationship.

These trade-offs improve flexibility and long-term maintainability.

---

# Design Principles

The following rules apply:

- Every Grade belongs to one Academic Year.
- A Grade may contain zero or more Sections.
- Grades may exist before Sections are created.
- Grades should remain stable throughout an Academic Year.
- Sections may be added or removed without affecting the Grade.

---

# Future Expansion

The Grade entity has been designed to support future capabilities including:

- Curriculum management
- Subject allocation
- Promotion rules
- Grade-specific reporting
- Capacity planning
- Academic analytics
- National curriculum mapping

These capabilities can be introduced without redesigning the entity.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-004 — School Entity Design
- ADR-007 — Academic Year Entity Design

Supports:

- ADR-009 — Section Entity Design
- ADR-010 — Learner Entity Design
- ADR-012 — Enrolment Entity Design
- ADR-013 — Attendance Event Model

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-001 — Model the Business, Not the Screen
- YEP-004 — Avoid Duplication
- YEP-005 — Engineer for Change
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

The Grade entity represents an **academic concept**, not a classroom.

A Grade should answer the question:

> "What educational level is this learner studying?"

It should **not** answer:

> "Which classroom is this learner in?"

That responsibility belongs to the Section entity.

Keeping these concepts separate preserves flexibility, supports parallel classes, and ensures EduCare accurately models the operational structure of modern educational institutions.

Whenever class structures change, the Grade remains stable while Sections can evolve to meet the school's operational needs.