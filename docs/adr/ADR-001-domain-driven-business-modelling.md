# ADR-001 — Domain-Driven Business Modelling

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

Traditional software projects often begin by designing user interfaces or database tables before fully understanding the business they are intended to support.

This frequently results in systems that mirror application screens rather than real-world business operations.

As requirements evolve, these systems become increasingly difficult to extend because the architecture is built around implementation details instead of the business domain.

For EduCare, we wanted a different approach.

The platform is intended to serve educational institutions over many years while adapting to changing academic structures, policies, and operational requirements.

To achieve this, the architecture must accurately represent how schools function rather than how individual screens are organised.

---

# Decision

EduCare will adopt a **Domain-Driven Business Modelling** approach.

The business domain will be modelled before designing:

- the database
- backend services
- APIs
- user interfaces

Every software component must represent a real business concept or business process.

Business entities, relationships, and historical events will form the foundation of the architecture.

User interfaces will be built on top of the business model—not the other way around.

---

# Rationale

Educational institutions operate according to well-defined business concepts such as:

- Schools
- Academic Years
- Grades
- Sections
- Learners
- Guardians
- Teachers
- Enrolments
- Attendance

These concepts exist independently of the software.

By modelling these business concepts directly, the software becomes easier to understand, extend, and maintain.

Future requirements can be accommodated by extending the business model rather than redesigning the application.

---

# Consequences

## Positive

- Software reflects real educational processes.
- Database design becomes more consistent.
- APIs naturally align with business operations.
- User interfaces remain flexible.
- Future features can be added without major redesign.
- New developers can understand the system through its business model.

## Trade-offs

- More time is invested in architectural planning before implementation.
- Early development progresses more slowly.
- Business analysis becomes an essential part of software engineering.

These trade-offs are considered worthwhile because they significantly reduce long-term complexity.

---

# Examples

Instead of designing around screens:

```

Learner Registration Screen

↓

Database

```

EduCare models the underlying business:

```

School
│
├── Academic Year
│
├── Grade
│
├── Section
│
├── Learner
│
├── Guardian
│
├── Enrolment
│
└── Attendance

```

User interfaces are then built on top of this domain model.

---

# Related ADRs

This decision establishes the foundation for all subsequent architectural decisions, including:

- ADR-002 — Multi-Tenant SaaS Architecture
- ADR-003 — Event-Driven Business Architecture
- ADR-004 — School Entity Design
- ADR-005 — User Entity Design
- ADR-006 — Role-Based Access Control
- ADR-007 — Academic Year Entity Design
- ADR-008 — Grade Entity Design
- ADR-009 — Section Entity Design
- ADR-010 — Learner Entity Design
- ADR-011 — Guardian Relationship Model
- ADR-012 — Enrolment Entity Design
- ADR-013 — Attendance Event Model

---

# Alignment with YapiTech Engineering Principles

This decision directly implements:

- YEP-001 — Model the Business, Not the Screen
- YEP-002 — Separate Identity from State
- YEP-003 — Preserve History
- YEP-005 — Engineer for Change
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

This ADR establishes the architectural philosophy of EduCare.

Every subsequent design decision should reinforce the business model rather than compromise it.

When faced with future architectural choices, preference should always be given to solutions that preserve the integrity of the business domain, maintain historical accuracy, and support long-term adaptability.