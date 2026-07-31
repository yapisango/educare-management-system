# YapiTech Engineering Philosophy

> We design software that models real businesses, preserves history, adapts to change, and communicates through well-defined business events.
>
> Every architectural decision should reduce future complexity rather than introduce it.
>
> We believe software should evolve with the business, not force the business to evolve around the software.

---

# YapiTech Engineering Principles

## 1. Model the Business, Not the Screen

Databases should represent real business concepts rather than user interface layouts.

---

## 2. Separate Identity from State

People remain the same.

Their roles, classes, enrolments, assignments, and relationships change over time.

Store these separately.

---

## 3. Preserve History

Never overwrite important business information.

Create historical records whenever possible.

---

## 4. Avoid Duplication

Every piece of information should have a single source of truth.

---

## 5. Build for Change

Businesses evolve.

Software should be easy to extend without redesigning the database.

---

## 6. Multi-Tenant by Design

Every business entity belongs to a School.

Schools operate independently.

---

## 7. Small, Independent Components

Every module should have a single responsibility.

---

## 8. Event-Driven by Design

Significant business actions should publish business events.

Modules should react to events rather than directly depending on one another whenever practical.

---

## 9. Documentation is Part of the Product

Architecture Decision Records (ADRs) explain why decisions were made, not just how they were implemented.

---

> **Engineering is about making tomorrow's changes easier than today's implementation.**

— YapiTech Engineering Philosophy