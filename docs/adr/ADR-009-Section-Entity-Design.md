# ADR-009 — Section Entity Design

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Within an Academic Year, schools organise learners into teaching groups known as Sections.

A Section represents a specific class group within a Grade.

For example:

- Grade 6
    - Section A
    - Section B
    - Section C

Schools may increase or reduce the number of Sections each year depending on learner enrolment, staffing, classroom availability, or operational requirements.

Because these operational groupings change more frequently than Grades, EduCare models Sections as an independent business entity.

---

# Decision

EduCare will model **Section** as an independent business entity belonging to a Grade.

A Section represents the operational grouping of learners for teaching purposes.

Learners are enrolled into Sections rather than directly into Grades.

Sections may be created, merged, renamed, or retired without affecting the Grade structure.

---

# Rationale

Separating Grades from Sections allows schools to adapt to changing operational needs without altering the academic structure.

Examples include:

- Opening an additional Section due to increased enrolment.
- Merging two Sections because of reduced learner numbers.
- Assigning different teachers to different Sections.
- Moving learners between Sections while remaining in the same Grade.

This design mirrors how schools manage classes in the real world.

---

# Entity Responsibilities

The Section entity represents a teaching group.

Typical information includes:

- Section Name
- Grade
- Academic Year
- Class Teacher (optional)
- Maximum Capacity
- Current Status

The Section does **not** store learner information directly.

Learners are associated through Enrolments.

---

# Business Relationships

Each Section belongs to one Grade.

Each Section may have:

- One Class Teacher
- Many Learner Enrolments
- Many Attendance Records
- Many Assessments
- Timetables

```
Academic Year
        │
        ▼
     Grade
        │
        ▼
     Section
        │
        ├── Teacher
        ├── Enrolments
        ├── Attendance
        ├── Assessments
        └── Timetable
```

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
            │
            ▼
        Enrolments
```

Sections organise learners within a Grade while preserving the academic hierarchy.

---

# Consequences

## Positive

- Supports unlimited parallel classes.
- Reflects real school operations.
- Simplifies learner allocation.
- Supports teacher assignments.
- Enables timetable generation.
- Makes attendance tracking straightforward.
- Improves classroom capacity planning.

## Trade-offs

- Introduces an additional entity.
- Learners reach a Grade indirectly through their Section.
- Timetable management becomes Section-based rather than Grade-based.

These trade-offs provide significantly greater flexibility for schools.

---

# Design Principles

The following rules apply:

- Every Section belongs to one Grade.
- A Grade may contain many Sections.
- Sections may exist before learners are enrolled.
- Learners belong to Sections through Enrolments.
- Sections may be created or retired without affecting historical records.
- Historical Sections remain available for reporting.

---

# Future Expansion

The Section entity has been designed to support future capabilities including:

- Homeroom teachers
- Classroom allocation
- Capacity management
- Seating plans
- Subject grouping
- Timetable generation
- Behaviour tracking
- Classroom resources
- Section performance analytics

These capabilities can be introduced without redesigning the entity.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-004 — School Entity Design
- ADR-007 — Academic Year Entity Design
- ADR-008 — Grade Entity Design

Supports:

- ADR-010 — Learner Entity Design
- ADR-011 — Guardian Relationship Model
- ADR-012 — Enrolment Entity Design
- ADR-013 — Attendance Event Model

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-001 — Model the Business, Not the Screen
- YEP-003 — Preserve History
- YEP-005 — Engineer for Change
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

The Section entity represents the operational structure of teaching rather than the academic structure of education.

A Grade answers:

> "What educational level is being taught?"

A Section answers:

> "Which teaching group is delivering that education?"

This distinction enables EduCare to adapt as schools grow, restructure classes, or adjust staffing without affecting the underlying academic model.

Sections are intentionally designed to be flexible operational units, allowing the software to evolve alongside the school's changing needs while preserving historical accuracy.