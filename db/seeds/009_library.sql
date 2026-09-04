BEGIN;

-- ============================================================
-- 009_library.sql
-- Seed school library book catalogue
-- ============================================================

INSERT INTO public.books (
    school_id,
    isbn,
    title,
    author,
    publisher,
    publication_year,
    edition,
    subject_id,
    grade_id,
    category,
    language,
    description
)
VALUES

-- Mathematics
(1, '9780000000001', 'Core Mathematics Grade 8', 'A. Mokoena', 'EduPress', 2024, '1st Edition', 1, 1, 'Mathematics', 'English', 'Foundation mathematics textbook covering algebra, geometry, measurement and statistics.'),
(1, '9780000000002', 'Core Mathematics Grade 9', 'L. Dlamini', 'EduPress', 2024, '1st Edition', 1, 2, 'Mathematics', 'English', 'Grade 9 mathematics textbook covering algebra, geometry, graphs and probability.'),
(1, '9780000000003', 'Core Mathematics Grade 10', 'T. Naidoo', 'EduPress', 2024, '2nd Edition', 1, 3, 'Mathematics', 'English', 'Grade 10 mathematics textbook covering functions, algebra, geometry and trigonometry.'),
(1, '9780000000004', 'Core Mathematics Grade 11', 'P. Jacobs', 'EduPress', 2024, '2nd Edition', 1, 4, 'Mathematics', 'English', 'Grade 11 mathematics textbook covering functions, sequences, analytical geometry and probability.'),
(1, '9780000000005', 'Core Mathematics Grade 12', 'N. Petersen', 'EduPress', 2024, '3rd Edition', 1, 5, 'Mathematics', 'English', 'Grade 12 mathematics examination preparation and advanced problem-solving textbook.'),

-- English
(1, '9780000000011', 'English Language Grade 8', 'S. Williams', 'Academic Press', 2024, '1st Edition', 2, 1, 'English', 'English', 'Language, reading comprehension, writing and communication skills for Grade 8.'),
(1, '9780000000012', 'English Language Grade 9', 'R. Adams', 'Academic Press', 2024, '1st Edition', 2, 2, 'English', 'English', 'Intermediate English language and literature skills for Grade 9 learners.'),
(1, '9780000000013', 'English Language Grade 10', 'J. Daniels', 'Academic Press', 2024, '2nd Edition', 2, 3, 'English', 'English', 'Senior phase English language, literature and communication textbook.'),
(1, '9780000000014', 'English Language Grade 11', 'M. Williams', 'Academic Press', 2024, '2nd Edition', 2, 4, 'English', 'English', 'Advanced English language and literature studies for Grade 11.'),
(1, '9780000000015', 'English Language Grade 12', 'K. Smith', 'Academic Press', 2024, '3rd Edition', 2, 5, 'English', 'English', 'Grade 12 English examination preparation, literature and academic writing.'),

-- Physical Science
(1, '9780000000021', 'Physical Science Grade 8', 'D. Khumalo', 'ScienceWorks', 2024, '1st Edition', 3, 1, 'Physical Science', 'English', 'Introduction to matter, energy, forces and scientific investigation.'),
(1, '9780000000022', 'Physical Science Grade 9', 'B. Molefe', 'ScienceWorks', 2024, '1st Edition', 3, 2, 'Physical Science', 'English', 'Grade 9 physical science covering matter, energy, forces and basic chemistry.'),
(1, '9780000000023', 'Physical Science Grade 10', 'C. van der Merwe', 'ScienceWorks', 2024, '2nd Edition', 3, 3, 'Physical Science', 'English', 'Grade 10 physics and chemistry fundamentals with practical activities.'),
(1, '9780000000024', 'Physical Science Grade 11', 'R. Botha', 'ScienceWorks', 2024, '2nd Edition', 3, 4, 'Physical Science', 'English', 'Grade 11 mechanics, waves, electricity and chemical systems.'),
(1, '9780000000025', 'Physical Science Grade 12', 'E. Maseko', 'ScienceWorks', 2024, '3rd Edition', 3, 5, 'Physical Science', 'English', 'Grade 12 physical science examination preparation and advanced problem solving.'),

-- Life Sciences
(1, '9780000000031', 'Life Sciences Grade 8', 'F. Ndlovu', 'BioLearn', 2024, '1st Edition', 4, 1, 'Life Sciences', 'English', 'Introduction to living organisms, cells, ecosystems and biodiversity.'),
(1, '9780000000032', 'Life Sciences Grade 9', 'G. Mthembu', 'BioLearn', 2024, '1st Edition', 4, 2, 'Life Sciences', 'English', 'Grade 9 life sciences covering cells, organisms, ecosystems and human biology.'),
(1, '9780000000033', 'Life Sciences Grade 10', 'H. Zulu', 'BioLearn', 2024, '2nd Edition', 4, 3, 'Life Sciences', 'English', 'Grade 10 biology covering cellular processes, biodiversity and environmental studies.'),
(1, '9780000000034', 'Life Sciences Grade 11', 'I. Mkhize', 'BioLearn', 2024, '2nd Edition', 4, 4, 'Life Sciences', 'English', 'Grade 11 genetics, evolution, biodiversity and human physiology.'),
(1, '9780000000035', 'Life Sciences Grade 12', 'J. Cele', 'BioLearn', 2024, '3rd Edition', 4, 5, 'Life Sciences', 'English', 'Grade 12 life sciences examination preparation and advanced biology topics.'),

-- History
(1, '9780000000041', 'History Grade 8', 'K. Dube', 'Heritage Press', 2024, '1st Edition', 5, 1, 'History', 'English', 'Introduction to historical sources, ancient societies and African history.'),
(1, '9780000000042', 'History Grade 9', 'L. Mkhwanazi', 'Heritage Press', 2024, '1st Edition', 5, 2, 'History', 'English', 'Grade 9 history covering colonialism, industrialisation and African societies.'),
(1, '9780000000043', 'History Grade 10', 'M. Sibeko', 'Heritage Press', 2024, '2nd Edition', 5, 3, 'History', 'English', 'Grade 10 history covering major political, social and economic developments.'),
(1, '9780000000044', 'History Grade 11', 'N. Maseko', 'Heritage Press', 2024, '2nd Edition', 5, 4, 'History', 'English', 'Grade 11 history covering twentieth-century South Africa and international developments.'),
(1, '9780000000045', 'History Grade 12', 'O. Khumalo', 'Heritage Press', 2024, '3rd Edition', 5, 5, 'History', 'English', 'Grade 12 history examination preparation and source-based historical analysis.');

COMMIT;
