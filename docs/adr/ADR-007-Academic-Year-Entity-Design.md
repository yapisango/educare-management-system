# ADR-007 — Academic Year Entity Design

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Educational institutions organise their activities around academic years.

Every learner enrolment, class allocation, attendance record, assessment, timetable, and report occurs within a specific academic year.

Without explicitly modelling the Academic Year, the platform cannot accurately preserve educational history or support long-term reporting.

EduCare therefore requires the Academic Year to be a first-class business entity.

---

# Decision

EduCare will model the **Academic Year** as an independent business entity owned by a School.

The Academic Year represents a defined period during which educational activities take place.

All academic records must belong to exactly one Academic Year.

---

# Rationale

An Academic Year is more than a calendar year.

Different schools may:

- start at different dates
- end at different dates
- have different term structures
- temporarily suspend operations
- reopen after interruptions

Treating the Academic Year as its own entity provides flexibility while preserving historical accuracy.

---

# Entity Responsibilities

The Academic Year is responsible for representing the operational school year.

Typical information includes:

- Academic Year Name
- Start Date
- End Date
- Current Status
- School
- Created Date
- Closed Date (optional)

The Academic Year does **not** contain learners, grades, or attendance directly.

Instead, it owns the academic structure for that period.

---

# Business Relationships

Each Academic Year belongs to one School.

An Academic Year owns:

- Grades
- Sections
- Enrolments
- Attendance
- Assessments
- Timetables
- Reports

This creates a complete historical snapshot of each school year.

---

# Domain Model

```
School
    │
    ▼
Academic Year
    │
    ├── Grades
    ├── Sections
    ├── Enrolments
    ├── Attendance
    ├── Assessments
    └── Reports
```

Every academic activity occurs within an Academic Year.

---

# Consequences

## Positive

- Complete academic history is preserved.
- Historical reporting becomes straightforward.
- Supports multiple school years.
- Simplifies promotion between years.
- Enables future analytics and forecasting.

## Trade-offs

- Every academic record requires an Academic Year reference.
- Additional relationships increase database complexity.

These trade-offs are justified because they provide accurate historical modelling.

---

# Design Principles

The following rules apply:

- Every Academic Year belongs to one School.
- Only one Academic Year may be marked as Active for a School at any given time.
- Academic Years are never reused.
- Closed Academic Years become historical records.
- Historical records remain immutable.

---

# Future Expansion

The Academic Year entity has been designed to support future capabilities including:

- Academic Terms
- Semester-based calendars
- Trimester calendars
- Examination periods
- Holiday calendars
- Promotion workflows
- Year-end archiving
- Academic planning

These capabilities can be added without redesigning the core entity.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-002 — Multi-Tenant SaaS Architecture
- ADR-003 — Event-Driven Business Architecture
- ADR-004 — School Entity Design

Supports:

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
- YEP-003 — Preserve History
- YEP-005 — Engineer for Change
- YEP-006 — Multi-Tenant by Design
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

The Academic Year establishes the **temporal boundary** of the EduCare domain.

While the School defines **ownership**, the Academic Year defines **time**.

Together they answer two fundamental architectural questions:

- **Which School owns this information?**
- **During which Academic Year did it occur?**

Every future academic feature should naturally fit within these two dimensions, ensuring that EduCare preserves both organisational ownership and historical accuracy throughout the lifecycle of the platform.