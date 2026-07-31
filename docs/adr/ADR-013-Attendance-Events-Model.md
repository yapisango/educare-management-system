# ADR-013 — Attendance Event Model

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Attendance is one of the most frequently recorded activities within a school.

Every school day, learners participate in classes and their attendance is recorded.

Attendance is not a permanent characteristic of a learner.

Instead, it represents something that occurred at a specific point in time.

Traditional systems often overwrite attendance status or tightly couple attendance directly to learners.

EduCare requires attendance to be modelled as a historical business event.

---

# Decision

EduCare will model **Attendance** as an independent business event.

Attendance belongs to an Enrolment rather than directly to a Learner.

Each Attendance record captures a learner's participation for a specific date.

Attendance records are immutable historical events and should never be overwritten.

Corrections should be recorded through business processes rather than replacing historical information.

---

# Rationale

Attendance answers the question:

> "What happened on this day?"

rather than:

> "Who is this learner?"

By linking attendance to Enrolment, EduCare automatically knows:

- School
- Academic Year
- Grade
- Section
- Learner

without duplicating those relationships.

This produces a cleaner domain model while preserving complete historical accuracy.

---

# Entity Responsibilities

The Attendance entity records a learner's attendance for a particular school day.

Typical information includes:

- Enrolment
- Attendance Date
- Attendance Status
- Recorded By
- Recorded Time
- Reason (optional)
- Notes (optional)

Attendance should never contain duplicated learner or class information.

---

# Attendance Status

Typical attendance states include:

- Present
- Absent
- Late
- Excused
- Sick
- School Activity
- Suspended

Additional statuses may be configured without redesigning the entity.

---

# Business Relationships

Each Attendance record belongs to:

- One Enrolment
- One Attendance Date
- One Recording User

```
Learner
      │
      ▼
Enrolment
      │
      ▼
Attendance
```

Attendance inherits the learner's academic context through the Enrolment.

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
    ▼
Section
    │
    ▼
Enrolment
    │
    ▼
Attendance
```

Attendance represents one daily participation event.

---

# Consequences

## Positive

- Preserves complete attendance history.
- Eliminates duplicated academic information.
- Supports accurate reporting.
- Enables attendance analytics.
- Supports compliance reporting.
- Simplifies auditing.
- Enables future predictive analysis.

## Trade-offs

- Creates a large number of historical records.
- Attendance queries rely on Enrolment relationships.
- Reporting becomes more relationship-driven.

These trade-offs are acceptable because they preserve the integrity and value of historical data.

---

# Design Principles

The following rules apply:

- Attendance belongs to an Enrolment.
- Attendance records are immutable.
- Attendance represents one day.
- Historical attendance is never deleted.
- Corrections should preserve an audit trail.
- Attendance status should be configurable.

---

# Future Expansion

The Attendance model has been designed to support future capabilities including:

- Lesson-by-lesson attendance
- QR code check-in
- Biometric attendance
- NFC/RFID attendance
- Parent notifications
- Attendance analytics
- Chronic absenteeism alerts
- Government attendance reporting
- AI-powered attendance prediction

These capabilities can be introduced without redesigning the core model.

---

# Related ADRs

Builds upon:

- ADR-003 — Event-Driven Business Architecture
- ADR-007 — Academic Year Entity Design
- ADR-009 — Section Entity Design
- ADR-010 — Learner Entity Design
- ADR-012 — Enrolment Entity Design

Future entities such as Behaviour Records, Assessment Results, Report Cards and School Fees should follow a similar event-driven approach where appropriate.

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

Attendance is not a characteristic of a learner.

It is evidence that a learner participated—or did not participate—in school on a specific date.

By modelling attendance as a business event linked to an Enrolment, EduCare preserves the complete educational journey while eliminating unnecessary duplication.

Every attendance record contributes to a permanent historical timeline that supports operational reporting, regulatory compliance, and future analytics.

When designing future features, ask:

> "Is this something the learner *is*, or something that *happened*?"

If it happened, it should almost certainly be modelled as an event.