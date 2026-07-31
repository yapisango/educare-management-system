# ADR-006 — Role-Based Access Control (RBAC) Model

**Status:** Accepted

**Date:** 2026-07-26

**Decision Makers:** YapiTech Architecture Team

---

# Context

EduCare serves multiple schools where different users perform different responsibilities.

Examples include:

- Principal
- Administrator
- Teacher
- Finance Officer
- Librarian
- Learner (future)
- Guardian (future)

Although these users interact with the same platform, they require different permissions.

A principal may manage the entire school.

A teacher should only manage their own classes.

A guardian should only access information relating to their own child.

The platform therefore requires a flexible and maintainable authorisation model.

---

# Decision

EduCare will implement **Role-Based Access Control (RBAC).**

Authentication identifies **who the user is.**

Roles determine **what the user is allowed to do.**

Permissions are assigned to Roles rather than directly to individual Users.

Users may have one or more Roles.

---

# Rationale

Separating identity from permissions provides significantly greater flexibility.

Rather than assigning permissions directly to every user, responsibilities are grouped into reusable roles.

This allows:

- consistent permission management
- easier administration
- reduced duplication
- future expansion

As organisational responsibilities change, only role assignments need updating.

The User identity remains unchanged.

---

# Role Examples

Typical roles include:

- Principal
- Administrator
- Teacher
- Finance Officer
- Receptionist
- Librarian
- Learner (future)
- Guardian (future)

Additional roles may be introduced without redesigning the User entity.

---

# Permission Examples

Examples of permissions include:

Academic

- View Learners
- Create Learners
- Edit Learners
- Archive Learners

Attendance

- Record Attendance
- View Attendance
- Edit Attendance

Administration

- Manage Users
- Assign Roles
- Configure Academic Years
- Manage Grades
- Manage Sections

Reporting

- View Reports
- Export Reports

Permissions remain independent of Users.

---

# Domain Model

```
School
    │
    ▼
User
    │
    ▼
UserRole
    │
    ▼
Role
    │
    ▼
Permission
```

Authentication determines identity.

Roles determine authorisation.

Permissions determine access.

---

# Consequences

## Positive

- Flexible permission management.
- Eliminates duplicated permission assignments.
- Supports multiple responsibilities.
- Simplifies administration.
- Easier auditing.
- Future-proof design.

## Trade-offs

- Additional database relationships.
- More sophisticated authorisation logic.
- Permission evaluation becomes part of every secured request.

These trade-offs are acceptable because they significantly improve scalability and maintainability.

---

# Design Principles

The following rules apply:

- Every authenticated person has one User identity.
- Users may hold multiple Roles.
- Roles contain Permissions.
- Permissions are never assigned directly to Users.
- Authorisation is evaluated within the context of a School.
- Business rules should reference permissions rather than role names wherever practical.

---

# Future Expansion

The RBAC model supports future capabilities including:

- Custom school-defined roles
- Temporary role assignments
- Delegated administration
- Fine-grained permissions
- Feature licensing
- Approval workflows
- Audit trails
- External identity providers

No redesign of the authorisation model should be required.

---

# Related ADRs

Builds upon:

- ADR-001 — Domain-Driven Business Modelling
- ADR-002 — Multi-Tenant SaaS Architecture
- ADR-005 — User Entity Design

Supports:

- ADR-007 — Academic Year Entity Design
- ADR-008 — Grade Entity Design
- ADR-009 — Section Entity Design
- ADR-010 — Learner Entity Design
- ADR-011 — Guardian Relationship Model
- ADR-012 — Enrolment Entity Design
- ADR-013 — Attendance Event Model

Every secured business operation should evaluate permissions through this model.

---

# Alignment with YapiTech Engineering Principles

This ADR directly implements:

- YEP-001 — Model the Business, Not the Screen
- YEP-002 — Separate Identity from State
- YEP-004 — Avoid Duplication
- YEP-005 — Engineer for Change
- YEP-006 — Multi-Tenant by Design
- YEP-008 — Documentation is Part of the Product

---

# Architect's Note

Authorisation should describe **capabilities**, not **job titles**.

A role is simply a convenient grouping of permissions.

Business rules should therefore ask:

> "Does this User have permission to perform this action?"

rather than:

> "Is this User a Principal?"

This distinction makes the platform significantly more flexible.

For example, a school may grant a Senior Teacher permission to manage attendance without making them an Administrator.

By authorising based on permissions rather than titles, EduCare can adapt to different organisational structures while maintaining a consistent security model.