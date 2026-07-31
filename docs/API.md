# EduCare Management System

# REST API Documentation

**Version:** 1.0  
**Status:** Living Document  
**Last Updated:** July 2026

---

# 1. Overview

The EduCare Management System exposes a RESTful API that enables secure communication between client applications and backend services.

The API is designed using modern REST principles and follows consistent standards for authentication, request validation, error handling, and versioning.

Supported clients include:

- Web Application
- Mobile Applications
- Parent Portal
- Teacher Portal
- Administration Portal
- Third-Party Integrations

---

# 2. API Principles

The EduCare API follows these principles:

- RESTful Design
- Stateless Requests
- JSON Communication
- Secure Authentication
- Predictable URLs
- Consistent Responses
- Versioned Endpoints
- Proper HTTP Status Codes

---

# 3. Base URL

Development

```
http://localhost:3000/api/v1
```

Production

```
https://api.educare.yapitech.co.za/api/v1
```

---

# 4. API Versioning

Versioning is included in every endpoint.

Example

```
/api/v1/
```

Future releases

```
/api/v2/
```

This allows older clients to continue functioning while new features are introduced.

---

# 5. Authentication

Authentication uses JSON Web Tokens (JWT).

Login request

```
POST /auth/login
```

Example Response

```json
{
  "token": "JWT_TOKEN",
  "expiresIn": 3600,
  "user": {
    "id": 1,
    "name": "John Smith",
    "role": "Administrator"
  }
}
```

The JWT token must be included in every protected request.

Example

```
Authorization: Bearer <JWT_TOKEN>
```

---

# 6. Content Type

All requests use JSON.

```
Content-Type: application/json
```

---

# 7. HTTP Methods

| Method | Purpose |
|---------|----------|
| GET | Retrieve data |
| POST | Create new resource |
| PUT | Replace resource |
| PATCH | Update resource |
| DELETE | Soft delete resource |

---

# 8. HTTP Status Codes

| Code | Meaning |
|--------|-----------|
| 200 | Success |
| 201 | Created |
| 204 | No Content |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 409 | Conflict |
| 422 | Validation Error |
| 500 | Internal Server Error |

---

# 9. Standard Response Format

Successful Response

```json
{
  "success": true,
  "message": "Request completed successfully.",
  "data": {}
}
```

---

Error Response

```json
{
  "success": false,
  "message": "Validation failed.",
  "errors": []
}
```

---

# 10. Authentication Endpoints

| Endpoint | Description |
|------------|-------------------------|
| POST /auth/login | User login |
| POST /auth/logout | User logout |
| POST /auth/register | Create user |
| POST /auth/refresh | Refresh token |
| POST /auth/change-password | Change password |

---

# 11. School Endpoints

| Endpoint | Description |
|------------|----------------|
| GET /schools | List schools |
| GET /schools/:id | School details |
| POST /schools | Create school |
| PUT /schools/:id | Update school |
| DELETE /schools/:id | Archive school |

---

# 12. User Endpoints

| Endpoint | Description |
|------------|----------------|
| GET /users | List users |
| GET /users/:id | User details |
| POST /users | Create user |
| PUT /users/:id | Update user |
| DELETE /users/:id | Disable user |

---

# 13. Learner Endpoints

| Endpoint | Description |
|------------|----------------|
| GET /learners | List learners |
| GET /learners/:id | Learner profile |
| POST /learners | Register learner |
| PUT /learners/:id | Update learner |
| DELETE /learners/:id | Archive learner |

---

# 14. Guardian Endpoints

| Endpoint | Description |
|------------|----------------|
| GET /guardians |
| POST /guardians |
| PUT /guardians/:id |
| DELETE /guardians/:id |

---

# 15. Academic Endpoints

Academic Years

```
GET /academic-years
POST /academic-years
PUT /academic-years/:id
DELETE /academic-years/:id
```

Grades

```
GET /grades
POST /grades
PUT /grades/:id
DELETE /grades/:id
```

Sections

```
GET /sections
POST /sections
PUT /sections/:id
DELETE /sections/:id
```

---

# 16. Enrolment Endpoints

```
GET /enrolments
POST /enrolments
PUT /enrolments/:id
DELETE /enrolments/:id
```

---

# 17. Attendance Endpoints

```
GET /attendance
POST /attendance
PUT /attendance/:id
DELETE /attendance/:id
```

---

# 18. Assessment Endpoints

```
GET /assessments
POST /assessments
PUT /assessments/:id
DELETE /assessments/:id
```

---

# 19. Finance Endpoints

Payments

```
GET /payments
POST /payments
PUT /payments/:id
```

Invoices

```
GET /invoices
POST /invoices
PUT /invoices/:id
```

Fees

```
GET /fees
POST /fees
PUT /fees/:id
```

---

# 20. Notification Endpoints

```
GET /notifications
POST /notifications
PUT /notifications/:id
```

---

# 21. Search API

Global Search

```
GET /search?q=john
```

Example

```
GET /search?q=Grade 8
```

---

# 22. Pagination

List endpoints support pagination.

Example

```
GET /learners?page=1&limit=20
```

Response

```json
{
  "page": 1,
  "limit": 20,
  "total": 348,
  "pages": 18,
  "data": []
}
```

---

# 23. Filtering

Example

```
GET /learners?grade=7
```

```
GET /attendance?date=2026-07-27
```

```
GET /payments?status=paid
```

---

# 24. Sorting

```
GET /learners?sort=name
```

```
GET /learners?sort=-createdAt
```

---

# 25. Rate Limiting

To protect the platform, the API implements request throttling.

Typical limits:

- Auth endpoints
- Login attempts
- Password reset requests

Excessive requests return

```
429 Too Many Requests
```

---

# 26. Security

Security measures include:

- HTTPS
- JWT Authentication
- RBAC
- Input Validation
- SQL Injection Protection
- XSS Protection
- CSRF Protection
- Secure Headers
- Audit Logging

---

# 27. Error Handling

Errors always return a structured response.

Example

```json
{
  "success": false,
  "message": "Learner not found.",
  "errorCode": "LEARNER_NOT_FOUND"
}
```

---

# 28. API Documentation Standards

All endpoints should include:

- Description
- Parameters
- Request Body
- Response Body
- Status Codes
- Authentication Requirements
- Example Requests
- Example Responses

---

# 29. Future API Enhancements

Future versions may include:

- GraphQL API
- WebSocket Notifications
- Public API Keys
- API Gateway
- Microservices
- Event Streaming
- OpenAPI (Swagger)
- SDK Generation

---

# 30. API Design Standards

The EduCare API follows the engineering standards defined in the YapiTech Engineering Handbook.

Key principles include:

- Consistency
- Simplicity
- Security
- Maintainability
- Scalability
- Developer Experience

---

# Document Status

This document evolves alongside the EduCare Management System and should be updated whenever new endpoints, authentication methods, or API standards are introduced.