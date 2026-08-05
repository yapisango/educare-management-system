--
-- PostgreSQL database dump
--

\restrict dBhG2x3QuaEyiFXYGj0ibCCrQRfuG3HC3tEa9Pvhed3vhxFa8atbJMFKfikHSgC

-- Dumped from database version 18.4
-- Dumped by pg_dump version 18.4

-- Started on 2026-08-05 19:40:35

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5736 (class 0 OID 16726)
-- Dependencies: 221
-- Data for Name: schools; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schools (id, public_id, school_name, school_code, email, phone, address, principal_name, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
1	93f14247-8a8a-42c1-b88e-1a09740fc2e0	EduCare High School	ECHS001	info@educare.co.za	0115551234	123 Main Road, Johannesburg	Mr John Smith	2026-08-02 15:27:06.436625+02	2026-08-02 15:27:06.436625+02	\N	\N	t
\.


--
-- TOC entry 5738 (class 0 OID 16752)
-- Dependencies: 223
-- Data for Name: academic_years; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.academic_years (id, public_id, school_id, academic_year_name, start_date, end_date, is_current, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
1	5ddf31e6-25d4-47c6-9e19-aaa713f94072	1	2026	2026-01-15	2026-12-10	t	2026-08-02 18:00:30.117654+02	2026-08-02 18:00:30.117654+02	\N	\N	t
\.


--
-- TOC entry 5740 (class 0 OID 16783)
-- Dependencies: 225
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.grades (id, public_id, school_id, grade_name, grade_code, display_order, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
1	4432ac72-1282-4360-975e-074d6146fb75	1	Grade 8	G08	8	2026-08-03 14:01:02.840507+02	2026-08-03 14:01:02.840507+02	\N	\N	t
2	d5b732fd-9d3a-4afe-8c86-027dfd33e70c	1	Grade 9	G09	9	2026-08-03 14:01:02.840507+02	2026-08-03 14:01:02.840507+02	\N	\N	t
3	2072866d-0824-4a6c-844f-fa02a03aae51	1	Grade 10	G10	10	2026-08-03 14:01:02.840507+02	2026-08-03 14:01:02.840507+02	\N	\N	t
4	b6c8adc3-f995-4d54-a9df-28efd77c207a	1	Grade 11	G11	11	2026-08-03 14:01:02.840507+02	2026-08-03 14:01:02.840507+02	\N	\N	t
5	9212be9b-3357-4c6a-9113-e252d7a18e8d	1	Grade 12	G12	12	2026-08-03 14:01:02.840507+02	2026-08-03 14:01:02.840507+02	\N	\N	t
\.


--
-- TOC entry 5742 (class 0 OID 16811)
-- Dependencies: 227
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sections (id, public_id, school_id, section_name, section_code, display_order, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5744 (class 0 OID 16839)
-- Dependencies: 229
-- Data for Name: classes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.classes (id, public_id, school_id, academic_year_id, grade_id, section_id, class_name, classroom, capacity, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5746 (class 0 OID 16885)
-- Dependencies: 231
-- Data for Name: departments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.departments (id, public_id, school_id, department_name, department_code, description, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
1	046cfef8-c88c-4c08-ade6-7a85c074205e	1	Academics	ACAD	Teaching and Learning	2026-08-02 15:34:35.185568+02	2026-08-02 15:34:35.185568+02	\N	\N	t
2	c6dbb52e-31a8-4c11-aa25-7e1cf68c8d54	1	Administration	ADMIN	School Administration	2026-08-02 15:34:35.185568+02	2026-08-02 15:34:35.185568+02	\N	\N	t
3	ae5c51da-a1e2-4715-927c-6466b84bfe9b	1	Finance	FIN	Financial Management	2026-08-02 15:34:35.185568+02	2026-08-02 15:34:35.185568+02	\N	\N	t
4	0f302440-9a44-4f76-94e1-5700876f667c	1	Human Resources	HR	Employee Management	2026-08-02 15:34:35.185568+02	2026-08-02 15:34:35.185568+02	\N	\N	t
5	5a81de69-b3a7-4627-ba8f-06dd90fa462e	1	ICT	ICT	Technology Department	2026-08-02 15:34:35.185568+02	2026-08-02 15:34:35.185568+02	\N	\N	t
6	17145304-951b-498b-9ee8-4785d8d41ca1	1	Sports	SPORT	Sports Department	2026-08-02 15:34:35.185568+02	2026-08-02 15:34:35.185568+02	\N	\N	t
7	56933670-1b53-448b-9285-79527be6d5cb	1	Facilities	FAC	Buildings and Maintenance	2026-08-02 15:34:35.185568+02	2026-08-02 15:34:35.185568+02	\N	\N	t
8	2145201b-c069-4c4c-95d8-d899e77cf651	1	Student Affairs	STU	Learner Support	2026-08-02 15:34:35.185568+02	2026-08-02 15:34:35.185568+02	\N	\N	t
\.


--
-- TOC entry 5748 (class 0 OID 16914)
-- Dependencies: 233
-- Data for Name: positions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.positions (id, public_id, department_id, position_name, position_code, description, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5750 (class 0 OID 17024)
-- Dependencies: 235
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, public_id, first_name, last_name, email, phone, date_of_birth, gender, username, password_hash, role, last_login, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5752 (class 0 OID 17056)
-- Dependencies: 237
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (id, public_id, user_id, school_id, department_id, position_id, employee_number, employment_type, employment_status, hire_date, termination_date, salary, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5762 (class 0 OID 17237)
-- Dependencies: 247
-- Data for Name: subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subjects (id, public_id, school_id, subject_code, subject_name, description, is_compulsory, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
1	d71a4e50-913d-4db1-8389-9f49483e26fc	1	MATH	Mathematics	\N	t	2026-08-03 13:29:51.302781+02	2026-08-03 13:29:51.302781+02	\N	\N	t
2	26e5fee7-570c-48f4-a52c-266f5425e48c	1	ENG	English	\N	t	2026-08-03 13:29:51.302781+02	2026-08-03 13:29:51.302781+02	\N	\N	t
3	7032a6c9-23bb-4e5f-bba1-afd79fbed3f0	1	PHY	Physical Science	\N	t	2026-08-03 13:29:51.302781+02	2026-08-03 13:29:51.302781+02	\N	\N	t
4	4768db3a-6c22-4175-b0f4-df904ac33074	1	LIFE	Life Sciences	\N	t	2026-08-03 13:29:51.302781+02	2026-08-03 13:29:51.302781+02	\N	\N	t
5	4077180f-c9de-4c6b-8101-88011244ee5e	1	HIST	History	\N	t	2026-08-03 13:29:51.302781+02	2026-08-03 13:29:51.302781+02	\N	\N	t
\.


--
-- TOC entry 5754 (class 0 OID 17107)
-- Dependencies: 239
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teachers (id, public_id, employee_id, teacher_registration_number, highest_qualification, specialization, years_experience, hire_date, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5772 (class 0 OID 17487)
-- Dependencies: 257
-- Data for Name: terms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.terms (id, public_id, academic_year_id, term_number, term_name, start_date, end_date, is_current, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
9	5621929e-464a-4441-b86c-a2f264726eb7	1	1	Term 1	2026-01-15	2026-03-28	f	2026-08-02 18:01:19.176201+02	2026-08-02 18:01:19.176201+02	\N	\N	t
10	98cdca62-6ab3-4e07-8cf2-3c29db76b3f3	1	2	Term 2	2026-04-08	2026-06-21	f	2026-08-02 18:01:19.176201+02	2026-08-02 18:01:19.176201+02	\N	\N	t
11	b383a573-3112-4448-8e67-f8fc456527a0	1	3	Term 3	2026-07-16	2026-09-27	t	2026-08-02 18:01:19.176201+02	2026-08-02 18:01:19.176201+02	\N	\N	t
12	6798ae85-67fd-4796-9cbc-a3bdb6137c2e	1	4	Term 4	2026-10-08	2026-12-10	f	2026-08-02 18:01:19.176201+02	2026-08-02 18:01:19.176201+02	\N	\N	t
\.


--
-- TOC entry 5774 (class 0 OID 17520)
-- Dependencies: 259
-- Data for Name: assessments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assessments (id, public_id, school_id, academic_year_id, term_id, subject_id, class_id, teacher_id, assessment_name, total_marks, pass_mark, assessment_date, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5756 (class 0 OID 17133)
-- Dependencies: 241
-- Data for Name: learners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.learners (id, public_id, user_id, school_id, class_id, learner_number, admission_date, enrolment_status, previous_school, medical_notes, emergency_contact_name, emergency_contact_phone, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5776 (class 0 OID 17579)
-- Dependencies: 261
-- Data for Name: assessment_results; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.assessment_results (id, public_id, assessment_id, learner_id, marks_obtained, percentage, grade_symbol, teacher_comment, is_absent, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5768 (class 0 OID 17336)
-- Dependencies: 253
-- Data for Name: attendance_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance_sessions (id, public_id, class_id, subject_id, teacher_id, academic_year_id, attendance_date, period_number, notes, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 5770 (class 0 OID 17381)
-- Dependencies: 255
-- Data for Name: attendance_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.attendance_entries (id, attendance_session_id, learner_id, remarks, recorded_at) FROM stdin;
\.


--
-- TOC entry 5820 (class 0 OID 18288)
-- Dependencies: 305
-- Data for Name: audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_logs (id, user_id, table_name, record_id, action_type, old_values, new_values, action_timestamp, ip_address) FROM stdin;
\.


--
-- TOC entry 5830 (class 0 OID 18414)
-- Dependencies: 315
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.books (id, public_id, school_id, isbn, title, author, publisher, publication_year, edition, subject_id, grade_id, category, language, description, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5766 (class 0 OID 17300)
-- Dependencies: 251
-- Data for Name: class_subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.class_subjects (id, class_id, subject_id, teacher_id, academic_year_id, created_at) FROM stdin;
\.


--
-- TOC entry 5786 (class 0 OID 17805)
-- Dependencies: 271
-- Data for Name: communication_channels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.communication_channels (id, public_id, channel_name, description, created_at, updated_at, is_active) FROM stdin;
1	349c3dfb-bb5b-42e9-bafe-9ec52cb55a18	EMAIL	Email notifications	2026-08-02 18:24:50.29414+02	2026-08-02 18:24:50.29414+02	t
2	92f82ae9-1169-4b1b-93ee-a32967e94e67	SMS	Text message notifications	2026-08-02 18:24:50.29414+02	2026-08-02 18:24:50.29414+02	t
3	23d5dba3-7bdf-40a0-b216-fafe2c89218f	PUSH	Mobile push notifications	2026-08-02 18:24:50.29414+02	2026-08-02 18:24:50.29414+02	t
4	90e1de65-5f43-425c-be4b-5462885929e0	IN_APP	In-app system notifications	2026-08-02 18:24:50.29414+02	2026-08-02 18:24:50.29414+02	t
5	d7e3a644-bd72-4f1e-9b93-71b829af7671	WHATSAPP	WhatsApp notifications	2026-08-02 18:24:50.29414+02	2026-08-02 18:24:50.29414+02	t
6	ff71a6dd-70e8-4260-a68a-897e72c48529	VOICE_CALL	Automated phone calls	2026-08-02 18:24:50.29414+02	2026-08-02 18:24:50.29414+02	t
\.


--
-- TOC entry 5788 (class 0 OID 17828)
-- Dependencies: 273
-- Data for Name: communication_templates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.communication_templates (id, public_id, template_name, channel_id, subject, message_body, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5822 (class 0 OID 18308)
-- Dependencies: 307
-- Data for Name: document_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_categories (id, public_id, category_name, description, created_at, updated_at, is_active) FROM stdin;
\.


--
-- TOC entry 5824 (class 0 OID 18331)
-- Dependencies: 309
-- Data for Name: documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.documents (id, public_id, category_id, uploaded_by, document_name, original_file_name, file_type, file_size, storage_path, mime_type, created_at, updated_at, is_active) FROM stdin;
\.


--
-- TOC entry 5828 (class 0 OID 18391)
-- Dependencies: 313
-- Data for Name: document_access_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_access_logs (id, document_id, user_id, action, accessed_at, ip_address) FROM stdin;
\.


--
-- TOC entry 5826 (class 0 OID 18366)
-- Dependencies: 311
-- Data for Name: document_versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.document_versions (id, document_id, version_number, storage_path, uploaded_at, uploaded_by) FROM stdin;
\.


--
-- TOC entry 5796 (class 0 OID 17951)
-- Dependencies: 281
-- Data for Name: fee_categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fee_categories (id, public_id, school_id, category_name, description, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
1	b964d8d7-3a52-4212-9ff2-ec7381995196	1	Tuition	Annual tuition fees	2026-08-02 20:25:24.899978+02	2026-08-02 20:25:24.899978+02	\N	\N	t
2	f0560392-3528-4fb1-80c7-7a8deecc7fa2	1	Registration	New learner registration	2026-08-02 20:25:24.899978+02	2026-08-02 20:25:24.899978+02	\N	\N	t
3	3a88ce15-6c0e-42df-bbde-e5f62420c0c9	1	Sports	Sports participation fees	2026-08-02 20:25:24.899978+02	2026-08-02 20:25:24.899978+02	\N	\N	t
4	14f2ae0c-9497-429e-b5c8-6241bdf698b2	1	Transport	School transport	2026-08-02 20:25:24.899978+02	2026-08-02 20:25:24.899978+02	\N	\N	t
5	7aabeb54-004b-4972-a9cb-812c6ec672b4	1	Library	Library services	2026-08-02 20:25:24.899978+02	2026-08-02 20:25:24.899978+02	\N	\N	t
6	f84aa8f6-09a6-4d98-a111-4c0b995ff6af	1	Examination	Exam fees	2026-08-02 20:25:24.899978+02	2026-08-02 20:25:24.899978+02	\N	\N	t
7	2dcf40ae-5ad5-4550-9544-539a3be239e4	1	Uniform	School uniforms	2026-08-02 20:25:24.899978+02	2026-08-02 20:25:24.899978+02	\N	\N	t
\.


--
-- TOC entry 5798 (class 0 OID 17980)
-- Dependencies: 283
-- Data for Name: fee_structures; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fee_structures (id, public_id, school_id, academic_year_id, grade_id, fee_category_id, fee_name, amount, due_date, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5840 (class 0 OID 18573)
-- Dependencies: 325
-- Data for Name: generator_addresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generator_addresses (id, house_number, street_name, city, province, postal_code, is_active, created_at) FROM stdin;
1	991	Republic Road	Kimberley	Northern Cape	8301	t	2026-08-04 20:56:05.559148+02
2	577	Malibongwe Drive	Mossel Bay	Western Cape	6500	t	2026-08-04 20:56:05.559148+02
3	460	Paul Kruger Street	Centurion	Gauteng	0157	t	2026-08-04 20:56:05.559148+02
4	804	School Road	Durban	KwaZulu-Natal	4001	t	2026-08-04 20:56:05.559148+02
5	445	Lynnwood Road	Soweto	Gauteng	1804	t	2026-08-04 20:56:05.559148+02
6	844	Musgrave Road	East London	Eastern Cape	5201	t	2026-08-04 20:56:05.559148+02
7	30	Voortrekker Road	Ballito	KwaZulu-Natal	4420	t	2026-08-04 20:56:05.559148+02
8	218	Bree Street	Jeffreys Bay	Eastern Cape	6330	t	2026-08-04 20:56:05.559148+02
9	769	Jan Smuts Avenue	Sandton	Gauteng	2196	t	2026-08-04 20:56:05.559148+02
10	772	Kloof Street	Thohoyandou	Limpopo	0950	t	2026-08-04 20:56:05.559148+02
11	193	Cedar Road	Paarl	Western Cape	7646	t	2026-08-04 20:56:05.559148+02
12	396	William Nicol Drive	Knysna	Western Cape	6571	t	2026-08-04 20:56:05.559148+02
13	400	Market Street	Pietermaritzburg	KwaZulu-Natal	3201	t	2026-08-04 20:56:05.559148+02
14	500	Lynnwood Road	Richards Bay	KwaZulu-Natal	3900	t	2026-08-04 20:56:05.559148+02
15	452	Paul Kruger Street	Cape Town	Western Cape	8001	t	2026-08-04 20:56:05.559148+02
16	154	Umgeni Road	Newcastle	KwaZulu-Natal	2940	t	2026-08-04 20:56:05.559148+02
17	144	King Street	Polokwane	Limpopo	0700	t	2026-08-04 20:56:05.559148+02
18	492	River Road	Pretoria	Gauteng	0001	t	2026-08-04 20:56:05.559148+02
19	848	Atterbury Road	Emalahleni	Mpumalanga	1035	t	2026-08-04 20:56:05.559148+02
20	377	Loop Street	Welkom	Free State	9459	t	2026-08-04 20:56:05.559148+02
21	129	Cedar Road	Johannesburg	Gauteng	2000	t	2026-08-04 20:56:05.559148+02
22	41	Loop Street	Kempton Park	Gauteng	1619	t	2026-08-04 20:56:05.559148+02
23	609	Pine Street	Mbombela	Mpumalanga	1200	t	2026-08-04 20:56:05.559148+02
24	705	Kloof Street	Midrand	Gauteng	1685	t	2026-08-04 20:56:05.559148+02
25	389	Paul Kruger Street	Mahikeng	North West	2745	t	2026-08-04 20:56:05.559148+02
26	622	Hendrik Potgieter Road	Stellenbosch	Western Cape	7600	t	2026-08-04 20:56:05.559148+02
27	378	Jan Smuts Avenue	Mthatha	Eastern Cape	5100	t	2026-08-04 20:56:05.559148+02
28	220	Long Street	Rustenburg	North West	0299	t	2026-08-04 20:56:05.559148+02
29	772	Station Road	Bloemfontein	Free State	9301	t	2026-08-04 20:56:05.559148+02
30	934	Education Street	George	Western Cape	6529	t	2026-08-04 20:56:05.559148+02
31	685	Main Road	Benoni	Gauteng	1501	t	2026-08-04 20:56:05.559148+02
32	681	Ontdekkers Road	Roodepoort	Gauteng	1724	t	2026-08-04 20:56:05.559148+02
33	641	High Street	Boksburg	Gauteng	1459	t	2026-08-04 20:56:05.559148+02
34	942	Voortrekker Road	Gqeberha	Eastern Cape	6001	t	2026-08-04 20:56:05.559148+02
35	166	Loop Street	Hermanus	Western Cape	7200	t	2026-08-04 20:56:05.559148+02
\.


--
-- TOC entry 5836 (class 0 OID 18497)
-- Dependencies: 321
-- Data for Name: generator_cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generator_cities (id, city, province, postal_code, is_active, created_at) FROM stdin;
1	Johannesburg	Gauteng	2000	t	2026-08-04 19:56:10.476329+02
2	Pretoria	Gauteng	0001	t	2026-08-04 19:56:10.476329+02
3	Centurion	Gauteng	0157	t	2026-08-04 19:56:10.476329+02
4	Midrand	Gauteng	1685	t	2026-08-04 19:56:10.476329+02
5	Sandton	Gauteng	2196	t	2026-08-04 19:56:10.476329+02
6	Roodepoort	Gauteng	1724	t	2026-08-04 19:56:10.476329+02
7	Soweto	Gauteng	1804	t	2026-08-04 19:56:10.476329+02
8	Kempton Park	Gauteng	1619	t	2026-08-04 19:56:10.476329+02
9	Benoni	Gauteng	1501	t	2026-08-04 19:56:10.476329+02
10	Boksburg	Gauteng	1459	t	2026-08-04 19:56:10.476329+02
11	Cape Town	Western Cape	8001	t	2026-08-04 19:56:10.476329+02
12	Stellenbosch	Western Cape	7600	t	2026-08-04 19:56:10.476329+02
13	Paarl	Western Cape	7646	t	2026-08-04 19:56:10.476329+02
14	George	Western Cape	6529	t	2026-08-04 19:56:10.476329+02
15	Mossel Bay	Western Cape	6500	t	2026-08-04 19:56:10.476329+02
16	Durban	KwaZulu-Natal	4001	t	2026-08-04 19:56:10.476329+02
17	Pietermaritzburg	KwaZulu-Natal	3201	t	2026-08-04 19:56:10.476329+02
18	Richards Bay	KwaZulu-Natal	3900	t	2026-08-04 19:56:10.476329+02
19	Newcastle	KwaZulu-Natal	2940	t	2026-08-04 19:56:10.476329+02
20	Gqeberha	Eastern Cape	6001	t	2026-08-04 19:56:10.476329+02
21	East London	Eastern Cape	5201	t	2026-08-04 19:56:10.476329+02
22	Mthatha	Eastern Cape	5100	t	2026-08-04 19:56:10.476329+02
23	Bloemfontein	Free State	9301	t	2026-08-04 19:56:10.476329+02
24	Welkom	Free State	9459	t	2026-08-04 19:56:10.476329+02
25	Polokwane	Limpopo	0700	t	2026-08-04 19:56:10.476329+02
26	Thohoyandou	Limpopo	0950	t	2026-08-04 19:56:10.476329+02
27	Mbombela	Mpumalanga	1200	t	2026-08-04 19:56:10.476329+02
28	Emalahleni	Mpumalanga	1035	t	2026-08-04 19:56:10.476329+02
29	Rustenburg	North West	0299	t	2026-08-04 19:56:10.476329+02
30	Mahikeng	North West	2745	t	2026-08-04 19:56:10.476329+02
31	Kimberley	Northern Cape	8301	t	2026-08-04 19:56:10.476329+02
32	Knysna	Western Cape	6571	t	2026-08-04 19:56:10.476329+02
33	Hermanus	Western Cape	7200	t	2026-08-04 19:56:10.476329+02
34	Ballito	KwaZulu-Natal	4420	t	2026-08-04 19:56:10.476329+02
35	Jeffreys Bay	Eastern Cape	6330	t	2026-08-04 19:56:10.476329+02
\.


--
-- TOC entry 5846 (class 0 OID 18624)
-- Dependencies: 331
-- Data for Name: generator_companies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generator_companies (id, company_name, industry, is_active, created_at) FROM stdin;
1	Standard Bank	Banking	t	2026-08-05 12:03:19.994103+02
2	Absa	Banking	t	2026-08-05 12:03:19.994103+02
3	FNB	Banking	t	2026-08-05 12:03:19.994103+02
4	Nedbank	Banking	t	2026-08-05 12:03:19.994103+02
5	Capitec	Banking	t	2026-08-05 12:03:19.994103+02
6	Vodacom	Telecommunications	t	2026-08-05 12:03:19.994103+02
7	MTN	Telecommunications	t	2026-08-05 12:03:19.994103+02
8	Telkom	Telecommunications	t	2026-08-05 12:03:19.994103+02
9	Cell C	Telecommunications	t	2026-08-05 12:03:19.994103+02
10	Rain	Telecommunications	t	2026-08-05 12:03:19.994103+02
11	Shoprite	Retail	t	2026-08-05 12:03:19.994103+02
12	Checkers	Retail	t	2026-08-05 12:03:19.994103+02
13	Pick n Pay	Retail	t	2026-08-05 12:03:19.994103+02
14	Woolworths	Retail	t	2026-08-05 12:03:19.994103+02
15	Makro	Retail	t	2026-08-05 12:03:19.994103+02
16	Game	Retail	t	2026-08-05 12:03:19.994103+02
17	Clicks	Retail	t	2026-08-05 12:03:19.994103+02
18	Dis-Chem	Retail	t	2026-08-05 12:03:19.994103+02
19	BMW South Africa	Automotive	t	2026-08-05 12:03:19.994103+02
20	Toyota South Africa	Automotive	t	2026-08-05 12:03:19.994103+02
21	Ford South Africa	Automotive	t	2026-08-05 12:03:19.994103+02
22	Volkswagen South Africa	Automotive	t	2026-08-05 12:03:19.994103+02
23	Mercedes-Benz South Africa	Automotive	t	2026-08-05 12:03:19.994103+02
24	Microsoft	Technology	t	2026-08-05 12:03:19.994103+02
25	Google	Technology	t	2026-08-05 12:03:19.994103+02
26	Apple	Technology	t	2026-08-05 12:03:19.994103+02
27	Amazon	Technology	t	2026-08-05 12:03:19.994103+02
28	Oracle	Technology	t	2026-08-05 12:03:19.994103+02
29	IBM	Technology	t	2026-08-05 12:03:19.994103+02
30	Sasol	Energy	t	2026-08-05 12:03:19.994103+02
31	Eskom	Energy	t	2026-08-05 12:03:19.994103+02
32	Anglo American	Mining	t	2026-08-05 12:03:19.994103+02
33	Exxaro	Mining	t	2026-08-05 12:03:19.994103+02
34	DHL	Logistics	t	2026-08-05 12:03:19.994103+02
35	FedEx	Logistics	t	2026-08-05 12:03:19.994103+02
36	Aramex	Logistics	t	2026-08-05 12:03:19.994103+02
37	EduCare High School	Education	t	2026-08-05 12:03:19.994103+02
38	University of South Africa	Education	t	2026-08-05 12:03:19.994103+02
39	University of Johannesburg	Education	t	2026-08-05 12:03:19.994103+02
40	Netcare	Healthcare	t	2026-08-05 12:03:19.994103+02
41	Life Healthcare	Healthcare	t	2026-08-05 12:03:19.994103+02
42	Mediclinic	Healthcare	t	2026-08-05 12:03:19.994103+02
43	YapiTech Innovations	Technology	t	2026-08-05 12:03:19.994103+02
\.


--
-- TOC entry 5842 (class 0 OID 18591)
-- Dependencies: 327
-- Data for Name: generator_email_domains; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generator_email_domains (id, domain, is_active, created_at) FROM stdin;
1	gmail.com	t	2026-08-05 11:27:44.778155+02
2	outlook.com	t	2026-08-05 11:27:44.778155+02
3	hotmail.com	t	2026-08-05 11:27:44.778155+02
4	icloud.com	t	2026-08-05 11:27:44.778155+02
5	yahoo.com	t	2026-08-05 11:27:44.778155+02
6	proton.me	t	2026-08-05 11:27:44.778155+02
7	live.com	t	2026-08-05 11:27:44.778155+02
8	mweb.co.za	t	2026-08-05 11:27:44.778155+02
9	webmail.co.za	t	2026-08-05 11:27:44.778155+02
10	vodamail.co.za	t	2026-08-05 11:27:44.778155+02
11	telkomsa.net	t	2026-08-05 11:27:44.778155+02
12	edu.za	t	2026-08-05 11:27:44.778155+02
13	ac.za	t	2026-08-05 11:27:44.778155+02
14	schoolmail.co.za	t	2026-08-05 11:27:44.778155+02
15	gov.za	t	2026-08-05 11:27:44.778155+02
16	company.co.za	t	2026-08-05 11:27:44.778155+02
17	business.co.za	t	2026-08-05 11:27:44.778155+02
18	corporate.co.za	t	2026-08-05 11:27:44.778155+02
19	educare.co.za	t	2026-08-05 11:27:44.778155+02
20	yapitech.co.za	t	2026-08-05 11:27:44.778155+02
21	google.com	t	2026-08-05 11:27:44.778155+02
22	microsoft.com	t	2026-08-05 11:27:44.778155+02
23	amazon.com	t	2026-08-05 11:27:44.778155+02
24	apple.com	t	2026-08-05 11:27:44.778155+02
25	oracle.com	t	2026-08-05 11:27:44.778155+02
26	ibm.com	t	2026-08-05 11:27:44.778155+02
27	intel.com	t	2026-08-05 11:27:44.778155+02
28	meta.com	t	2026-08-05 11:27:44.778155+02
\.


--
-- TOC entry 5832 (class 0 OID 18455)
-- Dependencies: 317
-- Data for Name: generator_first_names; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generator_first_names (id, first_name, gender, is_active) FROM stdin;
1	Sipho	Male	t
2	Sibusiso	Male	t
3	Thabo	Male	t
4	Themba	Male	t
5	Mandla	Male	t
6	Bongani	Male	t
7	Lwazi	Male	t
8	Ayanda	Male	t
9	Lindokuhle	Male	t
10	Vusi	Male	t
11	Mpho	Male	t
12	Andile	Male	t
13	Kagiso	Male	t
14	Neo	Male	t
15	Tshepo	Male	t
16	Lebo	Male	t
17	Gift	Male	t
18	Justice	Male	t
19	Trevor	Male	t
20	Brian	Male	t
21	Samuel	Male	t
22	Daniel	Male	t
23	John	Male	t
24	Peter	Male	t
25	Michael	Male	t
26	David	Male	t
27	Christopher	Male	t
28	Nicholas	Male	t
29	Richard	Male	t
30	Patrick	Male	t
31	Kevin	Male	t
32	Ryan	Male	t
33	Jason	Male	t
34	Moses	Male	t
35	Isaac	Male	t
36	Elijah	Male	t
37	Joseph	Male	t
38	Blessing	Male	t
39	Lucky	Male	t
40	Siyabonga	Male	t
41	Nkosinathi	Male	t
42	Mlondi	Male	t
43	Khaya	Male	t
44	Bheki	Male	t
45	Sizwe	Male	t
46	Mthokozisi	Male	t
47	Luthando	Male	t
48	Phumlani	Male	t
49	Jabulani	Male	t
50	Khulekani	Male	t
51	Nomsa	Female	t
52	Nomfundo	Female	t
53	Nosipho	Female	t
54	Lindiwe	Female	t
55	Thandi	Female	t
56	Nokuthula	Female	t
57	Zanele	Female	t
58	Buhle	Female	t
59	Hlengiwe	Female	t
60	Ayanda	Female	t
61	Ntombi	Female	t
62	Nompumelelo	Female	t
63	Amanda	Female	t
64	Precious	Female	t
65	Faith	Female	t
66	Hope	Female	t
67	Grace	Female	t
68	Mercy	Female	t
69	Joy	Female	t
70	Anna	Female	t
71	Sarah	Female	t
72	Mary	Female	t
73	Deborah	Female	t
74	Ruth	Female	t
75	Rebecca	Female	t
76	Rachel	Female	t
77	Esther	Female	t
78	Lebo	Female	t
79	Boitumelo	Female	t
80	Naledi	Female	t
81	Palesa	Female	t
82	Karabo	Female	t
83	Keabetswe	Female	t
84	Tebogo	Female	t
85	Nandi	Female	t
86	Phindile	Female	t
87	Sindisiwe	Female	t
88	Busisiwe	Female	t
89	Nonhlanhla	Female	t
90	Ntandoyenkosi	Female	t
91	Samukelisiwe	Female	t
92	Mbali	Female	t
93	Anele	Female	t
94	Zinhle	Female	t
95	Khanyisile	Female	t
96	Nosizwe	Female	t
97	Lerato	Female	t
98	Puleng	Female	t
99	Refilwe	Female	t
100	Mmatlou	Female	t
\.


--
-- TOC entry 5834 (class 0 OID 18481)
-- Dependencies: 319
-- Data for Name: generator_last_names; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generator_last_names (id, last_name, is_active, created_at) FROM stdin;
1	Nkosi	t	2026-08-04 18:51:07.722145+02
2	Dlamini	t	2026-08-04 18:51:07.722145+02
3	Zulu	t	2026-08-04 18:51:07.722145+02
4	Mokoena	t	2026-08-04 18:51:07.722145+02
5	Ndlovu	t	2026-08-04 18:51:07.722145+02
6	Khumalo	t	2026-08-04 18:51:07.722145+02
7	Mthembu	t	2026-08-04 18:51:07.722145+02
8	Mabaso	t	2026-08-04 18:51:07.722145+02
9	Mahlangu	t	2026-08-04 18:51:07.722145+02
11	Moloi	t	2026-08-04 18:51:07.722145+02
12	Molefe	t	2026-08-04 18:51:07.722145+02
13	Mokgosi	t	2026-08-04 18:51:07.722145+02
14	Mabena	t	2026-08-04 18:51:07.722145+02
15	Mashego	t	2026-08-04 18:51:07.722145+02
16	Maseko	t	2026-08-04 18:51:07.722145+02
17	Mabunda	t	2026-08-04 18:51:07.722145+02
20	Mogale	t	2026-08-04 18:51:07.722145+02
21	Mofokeng	t	2026-08-04 18:51:07.722145+02
23	Mokhele	t	2026-08-04 18:51:07.722145+02
24	Mokone	t	2026-08-04 18:51:07.722145+02
25	Mokwena	t	2026-08-04 18:51:07.722145+02
26	Mokoatle	t	2026-08-04 18:51:07.722145+02
27	Mokgatle	t	2026-08-04 18:51:07.722145+02
29	Mphahlele	t	2026-08-04 18:51:07.722145+02
30	Msimang	t	2026-08-04 18:51:07.722145+02
31	Mtshali	t	2026-08-04 18:51:07.722145+02
32	Ngcobo	t	2026-08-04 18:51:07.722145+02
33	Ngubane	t	2026-08-04 18:51:07.722145+02
34	Nxumalo	t	2026-08-04 18:51:07.722145+02
35	Ntuli	t	2026-08-04 18:51:07.722145+02
36	Shabalala	t	2026-08-04 18:51:07.722145+02
37	Sibiya	t	2026-08-04 18:51:07.722145+02
38	Sithole	t	2026-08-04 18:51:07.722145+02
39	Vilakazi	t	2026-08-04 18:51:07.722145+02
40	Xaba	t	2026-08-04 18:51:07.722145+02
41	Smith	t	2026-08-04 18:51:07.722145+02
42	Johnson	t	2026-08-04 18:51:07.722145+02
43	Brown	t	2026-08-04 18:51:07.722145+02
44	Williams	t	2026-08-04 18:51:07.722145+02
45	Jones	t	2026-08-04 18:51:07.722145+02
46	Taylor	t	2026-08-04 18:51:07.722145+02
47	Wilson	t	2026-08-04 18:51:07.722145+02
48	Thomas	t	2026-08-04 18:51:07.722145+02
49	Moore	t	2026-08-04 18:51:07.722145+02
50	Martin	t	2026-08-04 18:51:07.722145+02
51	Clark	t	2026-08-04 18:51:07.722145+02
52	Walker	t	2026-08-04 18:51:07.722145+02
53	Young	t	2026-08-04 18:51:07.722145+02
54	Allen	t	2026-08-04 18:51:07.722145+02
55	King	t	2026-08-04 18:51:07.722145+02
56	Scott	t	2026-08-04 18:51:07.722145+02
57	Green	t	2026-08-04 18:51:07.722145+02
58	Baker	t	2026-08-04 18:51:07.722145+02
59	Hill	t	2026-08-04 18:51:07.722145+02
60	Cooper	t	2026-08-04 18:51:07.722145+02
61	Botha	t	2026-08-04 18:51:07.722145+02
62	Van Wyk	t	2026-08-04 18:51:07.722145+02
63	Van Zyl	t	2026-08-04 18:51:07.722145+02
64	Pretorius	t	2026-08-04 18:51:07.722145+02
65	Du Toit	t	2026-08-04 18:51:07.722145+02
66	Steyn	t	2026-08-04 18:51:07.722145+02
67	Smit	t	2026-08-04 18:51:07.722145+02
68	Joubert	t	2026-08-04 18:51:07.722145+02
69	Kruger	t	2026-08-04 18:51:07.722145+02
70	De Villiers	t	2026-08-04 18:51:07.722145+02
71	Visser	t	2026-08-04 18:51:07.722145+02
72	Bosman	t	2026-08-04 18:51:07.722145+02
73	Fourie	t	2026-08-04 18:51:07.722145+02
74	Lombard	t	2026-08-04 18:51:07.722145+02
75	Marais	t	2026-08-04 18:51:07.722145+02
76	Naidoo	t	2026-08-04 18:51:07.722145+02
77	Pillay	t	2026-08-04 18:51:07.722145+02
78	Govender	t	2026-08-04 18:51:07.722145+02
79	Moodley	t	2026-08-04 18:51:07.722145+02
80	Reddy	t	2026-08-04 18:51:07.722145+02
81	Singh	t	2026-08-04 18:51:07.722145+02
82	Patel	t	2026-08-04 18:51:07.722145+02
83	Maharaj	t	2026-08-04 18:51:07.722145+02
84	Chetty	t	2026-08-04 18:51:07.722145+02
85	Desai	t	2026-08-04 18:51:07.722145+02
86	Yapi	t	2026-08-04 18:51:07.722145+02
87	Mensah	t	2026-08-04 18:51:07.722145+02
88	Boateng	t	2026-08-04 18:51:07.722145+02
89	Diallo	t	2026-08-04 18:51:07.722145+02
90	Kamara	t	2026-08-04 18:51:07.722145+02
91	Traore	t	2026-08-04 18:51:07.722145+02
92	Kone	t	2026-08-04 18:51:07.722145+02
93	Keita	t	2026-08-04 18:51:07.722145+02
94	Bah	t	2026-08-04 18:51:07.722145+02
95	Sow	t	2026-08-04 18:51:07.722145+02
\.


--
-- TOC entry 5844 (class 0 OID 18607)
-- Dependencies: 329
-- Data for Name: generator_phone_prefixes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generator_phone_prefixes (id, prefix, network_name, is_active, created_at) FROM stdin;
1	060	Vodacom	t	2026-08-05 11:36:36.549218+02
2	061	Vodacom	t	2026-08-05 11:36:36.549218+02
3	062	Vodacom	t	2026-08-05 11:36:36.549218+02
4	063	Vodacom	t	2026-08-05 11:36:36.549218+02
5	064	Vodacom	t	2026-08-05 11:36:36.549218+02
6	072	Vodacom	t	2026-08-05 11:36:36.549218+02
7	082	Vodacom	t	2026-08-05 11:36:36.549218+02
8	065	MTN	t	2026-08-05 11:36:36.549218+02
9	066	MTN	t	2026-08-05 11:36:36.549218+02
10	067	MTN	t	2026-08-05 11:36:36.549218+02
11	068	MTN	t	2026-08-05 11:36:36.549218+02
12	073	MTN	t	2026-08-05 11:36:36.549218+02
13	083	MTN	t	2026-08-05 11:36:36.549218+02
14	071	Cell C	t	2026-08-05 11:36:36.549218+02
15	074	Cell C	t	2026-08-05 11:36:36.549218+02
16	084	Cell C	t	2026-08-05 11:36:36.549218+02
17	081	Telkom	t	2026-08-05 11:36:36.549218+02
18	087	Rain	t	2026-08-05 11:36:36.549218+02
\.


--
-- TOC entry 5838 (class 0 OID 18557)
-- Dependencies: 323
-- Data for Name: generator_streets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.generator_streets (id, street_name, is_active, created_at) FROM stdin;
1	Church Street	t	2026-08-04 20:45:54.58426+02
2	Oxford Road	t	2026-08-04 20:45:54.58426+02
3	Jan Smuts Avenue	t	2026-08-04 20:45:54.58426+02
4	William Nicol Drive	t	2026-08-04 20:45:54.58426+02
5	Beyers Naude Drive	t	2026-08-04 20:45:54.58426+02
6	Malibongwe Drive	t	2026-08-04 20:45:54.58426+02
7	Republic Road	t	2026-08-04 20:45:54.58426+02
8	Hendrik Potgieter Road	t	2026-08-04 20:45:54.58426+02
9	Ontdekkers Road	t	2026-08-04 20:45:54.58426+02
10	Lynnwood Road	t	2026-08-04 20:45:54.58426+02
11	Atterbury Road	t	2026-08-04 20:45:54.58426+02
12	Pretorius Street	t	2026-08-04 20:45:54.58426+02
13	Paul Kruger Street	t	2026-08-04 20:45:54.58426+02
14	Steve Biko Road	t	2026-08-04 20:45:54.58426+02
15	Francis Baard Street	t	2026-08-04 20:45:54.58426+02
16	Hamilton Street	t	2026-08-04 20:45:54.58426+02
17	Schoeman Street	t	2026-08-04 20:45:54.58426+02
18	Long Street	t	2026-08-04 20:45:54.58426+02
19	Adderley Street	t	2026-08-04 20:45:54.58426+02
20	Bree Street	t	2026-08-04 20:45:54.58426+02
21	Loop Street	t	2026-08-04 20:45:54.58426+02
22	Kloof Street	t	2026-08-04 20:45:54.58426+02
23	Main Road	t	2026-08-04 20:45:54.58426+02
24	Voortrekker Road	t	2026-08-04 20:45:54.58426+02
25	Smith Street	t	2026-08-04 20:45:54.58426+02
26	West Street	t	2026-08-04 20:45:54.58426+02
27	Florida Road	t	2026-08-04 20:45:54.58426+02
28	Musgrave Road	t	2026-08-04 20:45:54.58426+02
29	Umgeni Road	t	2026-08-04 20:45:54.58426+02
30	School Road	t	2026-08-04 20:45:54.58426+02
31	Park Avenue	t	2026-08-04 20:45:54.58426+02
32	Station Road	t	2026-08-04 20:45:54.58426+02
33	Market Street	t	2026-08-04 20:45:54.58426+02
34	High Street	t	2026-08-04 20:45:54.58426+02
35	Oak Avenue	t	2026-08-04 20:45:54.58426+02
36	Pine Street	t	2026-08-04 20:45:54.58426+02
37	Cedar Road	t	2026-08-04 20:45:54.58426+02
38	Acacia Avenue	t	2026-08-04 20:45:54.58426+02
39	Sunset Boulevard	t	2026-08-04 20:45:54.58426+02
40	River Road	t	2026-08-04 20:45:54.58426+02
41	Garden Street	t	2026-08-04 20:45:54.58426+02
42	Palm Avenue	t	2026-08-04 20:45:54.58426+02
43	Rose Street	t	2026-08-04 20:45:54.58426+02
44	King Street	t	2026-08-04 20:45:54.58426+02
45	Queen Street	t	2026-08-04 20:45:54.58426+02
46	Nelson Mandela Drive	t	2026-08-04 20:45:54.58426+02
47	Freedom Way	t	2026-08-04 20:45:54.58426+02
48	Unity Road	t	2026-08-04 20:45:54.58426+02
49	Education Street	t	2026-08-04 20:45:54.58426+02
\.


--
-- TOC entry 5758 (class 0 OID 17178)
-- Dependencies: 243
-- Data for Name: guardians; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guardians (id, public_id, user_id, occupation, employer, work_phone, relationship_to_learner, preferred_contact_method, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5760 (class 0 OID 17204)
-- Dependencies: 245
-- Data for Name: guardian_learners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guardian_learners (id, guardian_id, learner_id, relationship, is_primary_contact, has_legal_custody, pickup_authorized, financial_responsibility, created_at) FROM stdin;
\.


--
-- TOC entry 5802 (class 0 OID 18072)
-- Dependencies: 287
-- Data for Name: invoices; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.invoices (id, public_id, learner_id, invoice_number, invoice_date, due_date, total_amount, balance_due, invoice_status, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5800 (class 0 OID 18025)
-- Dependencies: 285
-- Data for Name: learner_fee_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.learner_fee_assignments (id, public_id, learner_id, fee_structure_id, assigned_amount, discount_amount, final_amount, assigned_date, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5818 (class 0 OID 18270)
-- Dependencies: 303
-- Data for Name: login_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.login_history (id, user_id, login_time, logout_time, login_status, ip_address, device_information) FROM stdin;
\.


--
-- TOC entry 5790 (class 0 OID 17858)
-- Dependencies: 275
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (id, public_id, template_id, sender_user_id, notification_title, notification_message, scheduled_at, sent_at, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5794 (class 0 OID 17926)
-- Dependencies: 279
-- Data for Name: notification_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_logs (id, notification_id, channel_id, log_message, response_code, logged_at) FROM stdin;
\.


--
-- TOC entry 5792 (class 0 OID 17902)
-- Dependencies: 277
-- Data for Name: notification_recipients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_recipients (id, notification_id, user_id, delivery_status, delivered_at, read_at) FROM stdin;
\.


--
-- TOC entry 5804 (class 0 OID 18105)
-- Dependencies: 289
-- Data for Name: payment_methods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payment_methods (id, method_name, description, is_active) FROM stdin;
1	Cash	Cash payment	t
2	EFT	Electronic Funds Transfer	t
3	Credit Card	Card payment	t
4	Debit Card	Debit card	t
5	Debit Order	Monthly debit order	t
6	Mobile Money	Mobile payment	t
\.


--
-- TOC entry 5806 (class 0 OID 18120)
-- Dependencies: 291
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, public_id, invoice_id, payment_method_id, payment_date, amount_paid, reference_number, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5780 (class 0 OID 17664)
-- Dependencies: 265
-- Data for Name: periods; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.periods (id, public_id, school_id, period_number, period_name, start_time, end_time, is_break, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5812 (class 0 OID 18204)
-- Dependencies: 297
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permissions (id, public_id, permission_name, description, module_name, created_at, is_active) FROM stdin;
\.


--
-- TOC entry 5808 (class 0 OID 18152)
-- Dependencies: 293
-- Data for Name: receipts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.receipts (id, public_id, payment_id, receipt_number, receipt_date, amount, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5810 (class 0 OID 18181)
-- Dependencies: 295
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, public_id, role_name, description, created_at, updated_at, is_active) FROM stdin;
1	a8d6e665-8531-4559-b3a7-22fd5c4f3420	System Administrator	Full system access	2026-08-02 21:01:42.910288+02	2026-08-02 21:01:42.910288+02	t
2	183c68c3-2f3f-4401-ab8f-a68c500eb4c0	Principal	School administrator	2026-08-02 21:01:42.910288+02	2026-08-02 21:01:42.910288+02	t
3	bf6eab5b-81ea-4e93-a205-e25259dee257	Deputy Principal	Deputy school administrator	2026-08-02 21:01:42.910288+02	2026-08-02 21:01:42.910288+02	t
4	8b7c55a8-a5e9-4451-9a78-c27ee1775b49	Teacher	Teaching staff	2026-08-02 21:01:42.910288+02	2026-08-02 21:01:42.910288+02	t
5	27d8385a-9ca9-4099-8e3d-aba6ed7b2f68	Guardian	Parent or guardian	2026-08-02 21:01:42.910288+02	2026-08-02 21:01:42.910288+02	t
6	5f6fb430-e7cb-41e4-beb8-e5a30e773c40	Learner	Student	2026-08-02 21:01:42.910288+02	2026-08-02 21:01:42.910288+02	t
7	caba2669-48eb-4ee3-b832-3f5b3163d0d8	Finance Officer	Finance department	2026-08-02 21:01:42.910288+02	2026-08-02 21:01:42.910288+02	t
8	1fac3d11-c30a-4faf-bd7b-a7ccb82bcc4f	Receptionist	Front office	2026-08-02 21:01:42.910288+02	2026-08-02 21:01:42.910288+02	t
\.


--
-- TOC entry 5814 (class 0 OID 18225)
-- Dependencies: 299
-- Data for Name: role_permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_permissions (id, role_id, permission_id, created_at) FROM stdin;
\.


--
-- TOC entry 5778 (class 0 OID 17636)
-- Dependencies: 263
-- Data for Name: rooms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rooms (id, public_id, school_id, room_name, room_code, room_type, capacity, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5764 (class 0 OID 17269)
-- Dependencies: 249
-- Data for Name: teacher_subjects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teacher_subjects (id, teacher_id, subject_id, academic_year_id, assigned_date, created_at) FROM stdin;
\.


--
-- TOC entry 5782 (class 0 OID 17696)
-- Dependencies: 267
-- Data for Name: timetables; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timetables (id, public_id, school_id, academic_year_id, term_id, class_id, timetable_name, effective_from, effective_to, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5784 (class 0 OID 17754)
-- Dependencies: 269
-- Data for Name: timetable_entries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.timetable_entries (id, public_id, timetable_id, day_of_week, period_id, subject_id, teacher_id, room_id, created_at, updated_at, created_by, updated_by, is_active) FROM stdin;
\.


--
-- TOC entry 5816 (class 0 OID 18249)
-- Dependencies: 301
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_sessions (id, user_id, session_token, login_time, logout_time, ip_address, device_information, is_active) FROM stdin;
\.


--
-- TOC entry 5852 (class 0 OID 0)
-- Dependencies: 222
-- Name: academic_years_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.academic_years_id_seq', 1, true);


--
-- TOC entry 5853 (class 0 OID 0)
-- Dependencies: 260
-- Name: assessment_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assessment_results_id_seq', 1, false);


--
-- TOC entry 5854 (class 0 OID 0)
-- Dependencies: 258
-- Name: assessments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.assessments_id_seq', 1, false);


--
-- TOC entry 5855 (class 0 OID 0)
-- Dependencies: 254
-- Name: attendance_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_entries_id_seq', 1, false);


--
-- TOC entry 5856 (class 0 OID 0)
-- Dependencies: 252
-- Name: attendance_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.attendance_sessions_id_seq', 1, false);


--
-- TOC entry 5857 (class 0 OID 0)
-- Dependencies: 304
-- Name: audit_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_logs_id_seq', 1, false);


--
-- TOC entry 5858 (class 0 OID 0)
-- Dependencies: 314
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.books_id_seq', 10, true);


--
-- TOC entry 5859 (class 0 OID 0)
-- Dependencies: 250
-- Name: class_subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.class_subjects_id_seq', 1, false);


--
-- TOC entry 5860 (class 0 OID 0)
-- Dependencies: 228
-- Name: classes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.classes_id_seq', 1, false);


--
-- TOC entry 5861 (class 0 OID 0)
-- Dependencies: 270
-- Name: communication_channels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.communication_channels_id_seq', 6, true);


--
-- TOC entry 5862 (class 0 OID 0)
-- Dependencies: 272
-- Name: communication_templates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.communication_templates_id_seq', 1, false);


--
-- TOC entry 5863 (class 0 OID 0)
-- Dependencies: 230
-- Name: departments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.departments_id_seq', 8, true);


--
-- TOC entry 5864 (class 0 OID 0)
-- Dependencies: 312
-- Name: document_access_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_access_logs_id_seq', 1, false);


--
-- TOC entry 5865 (class 0 OID 0)
-- Dependencies: 306
-- Name: document_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_categories_id_seq', 1, false);


--
-- TOC entry 5866 (class 0 OID 0)
-- Dependencies: 310
-- Name: document_versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.document_versions_id_seq', 1, false);


--
-- TOC entry 5867 (class 0 OID 0)
-- Dependencies: 308
-- Name: documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.documents_id_seq', 1, false);


--
-- TOC entry 5868 (class 0 OID 0)
-- Dependencies: 236
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_id_seq', 1, false);


--
-- TOC entry 5869 (class 0 OID 0)
-- Dependencies: 280
-- Name: fee_categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fee_categories_id_seq', 7, true);


--
-- TOC entry 5870 (class 0 OID 0)
-- Dependencies: 282
-- Name: fee_structures_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.fee_structures_id_seq', 1, false);


--
-- TOC entry 5871 (class 0 OID 0)
-- Dependencies: 324
-- Name: generator_addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generator_addresses_id_seq', 35, true);


--
-- TOC entry 5872 (class 0 OID 0)
-- Dependencies: 320
-- Name: generator_cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generator_cities_id_seq', 35, true);


--
-- TOC entry 5873 (class 0 OID 0)
-- Dependencies: 330
-- Name: generator_companies_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generator_companies_id_seq', 43, true);


--
-- TOC entry 5874 (class 0 OID 0)
-- Dependencies: 326
-- Name: generator_email_domains_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generator_email_domains_id_seq', 28, true);


--
-- TOC entry 5875 (class 0 OID 0)
-- Dependencies: 316
-- Name: generator_first_names_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generator_first_names_id_seq', 100, true);


--
-- TOC entry 5876 (class 0 OID 0)
-- Dependencies: 318
-- Name: generator_last_names_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generator_last_names_id_seq', 95, true);


--
-- TOC entry 5877 (class 0 OID 0)
-- Dependencies: 328
-- Name: generator_phone_prefixes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generator_phone_prefixes_id_seq', 18, true);


--
-- TOC entry 5878 (class 0 OID 0)
-- Dependencies: 322
-- Name: generator_streets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.generator_streets_id_seq', 49, true);


--
-- TOC entry 5879 (class 0 OID 0)
-- Dependencies: 224
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.grades_id_seq', 5, true);


--
-- TOC entry 5880 (class 0 OID 0)
-- Dependencies: 244
-- Name: guardian_learners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guardian_learners_id_seq', 1, false);


--
-- TOC entry 5881 (class 0 OID 0)
-- Dependencies: 242
-- Name: guardians_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guardians_id_seq', 1, false);


--
-- TOC entry 5882 (class 0 OID 0)
-- Dependencies: 286
-- Name: invoices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.invoices_id_seq', 1, false);


--
-- TOC entry 5883 (class 0 OID 0)
-- Dependencies: 284
-- Name: learner_fee_assignments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.learner_fee_assignments_id_seq', 1, false);


--
-- TOC entry 5884 (class 0 OID 0)
-- Dependencies: 240
-- Name: learners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.learners_id_seq', 1, false);


--
-- TOC entry 5885 (class 0 OID 0)
-- Dependencies: 302
-- Name: login_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.login_history_id_seq', 1, false);


--
-- TOC entry 5886 (class 0 OID 0)
-- Dependencies: 278
-- Name: notification_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_logs_id_seq', 1, false);


--
-- TOC entry 5887 (class 0 OID 0)
-- Dependencies: 276
-- Name: notification_recipients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_recipients_id_seq', 1, false);


--
-- TOC entry 5888 (class 0 OID 0)
-- Dependencies: 274
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_id_seq', 1, false);


--
-- TOC entry 5889 (class 0 OID 0)
-- Dependencies: 288
-- Name: payment_methods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payment_methods_id_seq', 6, true);


--
-- TOC entry 5890 (class 0 OID 0)
-- Dependencies: 290
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 1, false);


--
-- TOC entry 5891 (class 0 OID 0)
-- Dependencies: 264
-- Name: periods_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.periods_id_seq', 1, false);


--
-- TOC entry 5892 (class 0 OID 0)
-- Dependencies: 296
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permissions_id_seq', 1, false);


--
-- TOC entry 5893 (class 0 OID 0)
-- Dependencies: 232
-- Name: positions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.positions_id_seq', 1, false);


--
-- TOC entry 5894 (class 0 OID 0)
-- Dependencies: 292
-- Name: receipts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.receipts_id_seq', 1, false);


--
-- TOC entry 5895 (class 0 OID 0)
-- Dependencies: 298
-- Name: role_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.role_permissions_id_seq', 1, false);


--
-- TOC entry 5896 (class 0 OID 0)
-- Dependencies: 294
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 8, true);


--
-- TOC entry 5897 (class 0 OID 0)
-- Dependencies: 262
-- Name: rooms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rooms_id_seq', 1, false);


--
-- TOC entry 5898 (class 0 OID 0)
-- Dependencies: 220
-- Name: schools_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.schools_id_seq', 1, true);


--
-- TOC entry 5899 (class 0 OID 0)
-- Dependencies: 226
-- Name: sections_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sections_id_seq', 1, false);


--
-- TOC entry 5900 (class 0 OID 0)
-- Dependencies: 246
-- Name: subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.subjects_id_seq', 5, true);


--
-- TOC entry 5901 (class 0 OID 0)
-- Dependencies: 248
-- Name: teacher_subjects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teacher_subjects_id_seq', 1, false);


--
-- TOC entry 5902 (class 0 OID 0)
-- Dependencies: 238
-- Name: teachers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teachers_id_seq', 1, false);


--
-- TOC entry 5903 (class 0 OID 0)
-- Dependencies: 256
-- Name: terms_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.terms_id_seq', 12, true);


--
-- TOC entry 5904 (class 0 OID 0)
-- Dependencies: 268
-- Name: timetable_entries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timetable_entries_id_seq', 1, false);


--
-- TOC entry 5905 (class 0 OID 0)
-- Dependencies: 266
-- Name: timetables_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.timetables_id_seq', 1, false);


--
-- TOC entry 5906 (class 0 OID 0)
-- Dependencies: 300
-- Name: user_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_sessions_id_seq', 1, false);


--
-- TOC entry 5907 (class 0 OID 0)
-- Dependencies: 234
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


-- Completed on 2026-08-05 19:40:44

--
-- PostgreSQL database dump complete
--

\unrestrict dBhG2x3QuaEyiFXYGj0ibCCrQRfuG3HC3tEa9Pvhed3vhxFa8atbJMFKfikHSgC

