CREATE TABLE [USER] (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Fullname NVARCHAR(50) NOT NULL,
    Username NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL unique,
    Password NVARCHAR(100) NOT NULL,
    RegistrationDate DATETIME NOT NULL DEFAULT GETDATE(),
    Bio NVARCHAR(200)
);


CREATE TABLE INSTRUCTOR (
    InstructorID INT PRIMARY KEY IDENTITY(1,1),
    name NVARCHAR(200) NOT NULL,
    ExpertiseArea NVARCHAR(50) NOT NULL,
    Verified BIT NOT NULL DEFAULT 0
);


CREATE TABLE COURSE (
    CourseID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(200),
    InstructorID INT NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    TotalNumberOfLectures INT NOT NULL,
    ReleaseDate DATETIME,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);


CREATE TABLE ENROLLMENT (
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATETIME NOT NULL DEFAULT GETDATE(),
    NumberOfLecturesCompleted INT NOT NULL DEFAULT 0,
    PRIMARY KEY (UserID, CourseID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE REVIEW (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    Rating INT CHECK (Rating>=1 and rating<=5),  --between 1 and 5
    Comment NVARCHAR(200),
    ReviewDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


CREATE TABLE PAYMENT (
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    PaymentDate DATETIME NOT NULL DEFAULT GETDATE(),
    Amount DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (UserID, CourseID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


CREATE TABLE CONTACTFORM (
    ContactFormID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(200) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Subject NVARCHAR(200) NOT NULL,
    Message NVARCHAR(200) NOT NULL,
    Date DATETIME NOT NULL DEFAULT GETDATE(),
);

CREATE TABLE DISCUSSIONFORUM (
    ForumID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT NOT NULL,
    Topic NVARCHAR(100),
    UserID INT NOT NULL,
    Message NVARCHAR(200) NOT NULL,
    DatePosted DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID)
);

CREATE TABLE ASSIGNMENT (
    AssignmentID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(200),
    Deadline DATETIME,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE CERTIFICATE (
    UserID INT NOT NULL,
    CourseID INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    DateIssued DATETIME NOT NULL DEFAULT GETDATE(),
    PRIMARY KEY (UserID, CourseID),
    FOREIGN KEY (UserID) REFERENCES [User](UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


CREATE TABLE LECTURE (
    LectureID INT PRIMARY KEY IDENTITY(1,1),
    CourseID INT NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    Description NVARCHAR(200),
    VideoURL NVARCHAR(200), -- Assuming lectures might include videos
    LectureOrder INT NOT NULL, -- To maintain the order of lectures within a course
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);


--deleting the data from the tables
delete from [user]
delete from [INSTRUCTOR]
delete from [course]
truncate table ENROLLMENT
truncate table REVIEW
truncate table PAYMENT
truncate table CONTACTFORM
truncate table DISCUSSIONFORUM
truncate table ASSIGNMENT
truncate table CERTIFICATE
truncate table Lecture


--sets identity columns to 0
DBCC CHECKIDENT ('[user]', RESEED, 0)
DBCC CHECKIDENT ('[INSTRUCTOR]', RESEED, 0)
DBCC CHECKIDENT ('[course]', RESEED, 0)
DBCC CHECKIDENT ('ENROLLMENT', RESEED, 0)
DBCC CHECKIDENT ('REVIEW', RESEED, 0)
DBCC CHECKIDENT ('PAYMENT', RESEED, 0)
DBCC CHECKIDENT ('CONTACTFORM', RESEED, 0)
DBCC CHECKIDENT ('DISCUSSIONFORUM', RESEED, 0)
DBCC CHECKIDENT ('ASSIGNMENT', RESEED, 0)
DBCC CHECKIDENT ('CERTIFICATE', RESEED, 0)
DBCC CHECKIDENT ('LECTURE', RESEED, 0)




-- Inserting into [USER] table
INSERT INTO [USER] (Fullname, Username, Email, Password, Bio)
VALUES 
('Muhammad Ali', 'mohammadali', 'mohammadali@example.com', 'password123', 'Professional Mechanical Engineer'),
('Sarah Khan', 'sarahkhan', 'sarah.khan@example.com', 'password123', 'Expert in Physics'),
('Ahmed Khan', 'ahmedkhan', 'ahmed.khan@example.com', 'password123', 'Freelance Developer'),
('Ayesha Mahmood', 'ayeshamahmood', 'ayesha.mahmood@example.com', 'password123', 'Software Engineer at ABC Company'),
('Usman Ahmed', 'usmanahmed', 'usman.ahmed@example.com', 'password123', 'Student at XYZ University'),
('Fatima Ali', 'fatimaali', 'fatima.ali@example.com', 'password123', 'Accountant at XYZ Firm'),
('Zainab Khan', 'zainabkhan', 'zainab.khan@example.com', 'password123', 'Graphic Designer'),
('Imran Haider', 'imranhaider', 'imran.haider@example.com', 'password123', 'Digital Marketer'),
('Sana Abbas', 'sanaabbas', 'sana.abbas@example.com', 'password123', 'Teacher at XYZ School'),
('Ali Raza', 'aliraza', 'ali.raza@example.com', 'password123', 'Electrical Engineer');


-- Inserting into INSTRUCTOR table
INSERT INTO INSTRUCTOR (name, ExpertiseArea, Verified)
VALUES 
('Muhammad Ramza','Web Development', 1),
('Aqib Zeeshan','Database', 1),
('Zareen Alamgir','Data Structure', 1),
('Gulsher Chaudhary','Graphic Design', 1),
('Amna Ali','Digital Marketing', 0),
('Ahmed Asif','Accounting', 1),
('Muhammad Munir','Computer Science', 1),
('Ibrahim Ahsan','Mathematics', 0),
('Samiullah Kashif','Physics', 1),
('Tehreem Fatima','Chemistry', 0);


-- Inserting into COURSE table
INSERT INTO COURSE (Title, Description, InstructorID, Category, Price, TotalNumberOfLectures, ReleaseDate)
VALUES
('Web Development Fundamentals', 'Learn the basics of web development.', 1, 'Programming', 200.00, 3, '2022-01-15'),
('Database Systems', 'Explore database concepts and design.', 2, 'Computer Science', 250.00, 2, '2022-02-20'),
('Data Structures and Algorithms', 'Master data structures and algorithms.', 3, 'Programming', 200.00, 4, '2022-03-25'),
('Graphic Design Fundamentals', 'Learn the fundamentals of graphic design.', 4, 'Design', 180.00, 2, '2022-04-01'),
('Digital Marketing Strategies', 'Explore effective digital marketing strategies.', 5, 'Marketing', 220.00, 2, '2022-05-05'),
('Accounting Principles', 'Understand fundamental accounting principles.', 6, 'Finance', 200.00, 2, '2022-06-10'),
('Computer Science Basics', 'Learn the basics of computer science.', 7, 'Programming', 180.00, 2, '2022-07-15'),
('Mathematics Fundamentals', 'Explore fundamental concepts of mathematics.', 8, 'Mathematics', 150.00, 1, '2022-08-20'),
('Physics Essentials', 'Master essential concepts of physics.', 9, 'Science', 200.00, 3, '2022-09-25'),
('Chemistry Basics', 'Learn the basics of chemistry.', 10, 'Science', 180.00, 3, '2022-10-01');


-- Inserting into ENROLLMENT table
INSERT INTO ENROLLMENT (UserID, CourseID, EnrollmentDate, NumberOfLecturesCompleted)
VALUES 
(1, 1, '2022-01-20', 0),
(2, 2, '2022-02-25', 1),
(3, 3, '2022-03-30', 1),
(4, 4, '2022-04-05', 0),
(5, 5, '2022-05-10', 0),
(6, 6, '2022-06-15', 2),
(7, 7, '2022-07-20', 0),
(8, 8, '2022-08-25', 1),
(9, 9, '2022-09-30', 1),
(10, 10, '2022-10-05', 1);


-- Inserting into REVIEW table
INSERT INTO REVIEW (UserID, CourseID, Rating, Comment, ReviewDate)
VALUES 
(1, 1, 5, 'Great course!', '2022-01-25'),
(2, 2, 4, 'Good course', '2022-02-28'),
(3, 3, 5, 'Excellent course!', '2022-03-30');


-- Inserting into PAYMENT table
INSERT INTO PAYMENT (UserID, CourseID, PaymentDate, Amount)
VALUES 
(1, 1, '2022-01-20', 200.00),
(2, 2, '2022-02-25', 250.00),
(3, 3, '2022-03-30', 150.00),
(4, 4, '2022-04-05', 180.00),
(5, 5, '2022-05-10', 220.00),
(6, 6, '2022-06-15', 200.00),
(7, 7, '2022-07-20', 180.00),
(8, 8, '2022-08-25', 150.00),
(9, 9, '2022-09-30', 200.00),
(10, 10, '2022-10-05', 180.00);


-- Inserting into DISCUSSIONFORUM table
INSERT INTO DISCUSSIONFORUM (CourseID, Topic, UserID, Message, DatePosted)
VALUES 
(1, 'HTML Basics', 1, 'Im having trouble understanding HTML tags.', '2022-01-20');


-- Inserting into ASSIGNMENT table
INSERT INTO ASSIGNMENT (CourseID, Title, Description, Deadline)
VALUES 
(1, 'HTML Quiz', 'Complete the HTML quiz by the deadline.', '2022-01-30'),
(2, 'Data Analysis Project', 'Submit a data analysis project report.', '2022-02-28'),
(3, 'Essay Writing Assignment', 'Write an essay on a given topic.', '2022-03-31'),
(4, 'Logo Design Task', 'Design a logo for a fictional company.', '2022-04-10'),
(5, 'SEO Optimization Plan', 'Develop an SEO optimization plan for a website.', '2022-05-15'),
(6, 'Financial Statements Analysis Report', 'Analyze financial statements of a company.', '2022-06-20'),
(7, 'Algorithm Implementation', 'Implement a sorting algorithm in a programming language.', '2022-07-25'),
(8, 'Geometry Problem Set', 'Solve the given geometry problem set.', '2022-08-30'),
(9, 'Physics Experiment', 'Conduct a physics experiment and report the results.', '2022-09-30'),
(10, 'Chemical Reactions Research Paper', 'Write a research paper on chemical reactions.', '2022-10-05');


-- Inserting into CERTIFICATE table
INSERT INTO CERTIFICATE (UserID, CourseID, Title, DateIssued)
VALUES 
(1, 1, 'Web Development Fundamentals Certificate', '2022-02-05'),
(2, 2, 'Data Science Essentials Certificate', '2022-03-10'),
(3, 3, 'English Language Basics Certificate', '2022-04-15'),
(4, 4, 'Graphic Design Fundamentals Certificate', '2022-05-20'),
(5, 5, 'Digital Marketing Strategies Certificate', '2022-06-25'),
(6, 6, 'Accounting Principles Certificate', '2022-07-30'),
(7, 7, 'Computer Science Basics Certificate', '2022-08-05'),
(8, 8, 'Mathematics Fundamentals Certificate', '2022-09-10'),
(9, 9, 'Physics Essentials Certificate', '2022-10-15'),
(10, 10, 'Chemistry Basics Certificate', '2022-11-01');


INSERT INTO LECTURE (CourseID, Title, Description, VideoURL, LectureOrder)
VALUES
-- Course 1: Web Development Fundamentals (3 lectures)
(1, 'Learning Java Day 1', 'Understanding the basics of Java', 'https://www.youtube.com/watch?v=mG4NLNZ37y4&ab_channel=NesoAcademy', 1),
(1, 'Learning Java Day 2', 'Variables in Java', 'https://www.youtube.com/watch?v=LusTv0RlnSU&ab_channel=ApnaCollege', 2),
(1, 'Learning Java Day 3', 'Conditional Statements', 'https://www.youtube.com/watch?v=I5srDu75h_M&ab_channel=ApnaCollege', 3),

-- Course 2: Database Systems (2 lectures)
(2, 'Introduction to Database Systems', 'Overview of database concepts', 'https://youtu.be/wClEbCyWryI?si=4w8xosEyHR4R0OHX', 1),
(2, 'Database Design and Implementation', 'Designing and implementing databases', 'https://youtu.be/qoAL4MA3P08?si=rKbvFm_1a1DWB355', 2),

-- Course 3: Data Structures and Algorithms (4 lectures)
(3, 'Introduction to Data Structures', 'Overview of data structures', 'https://youtu.be/3cU__spdMIw?si=S1BAjQSGLxClI9xX', 1),
(3, 'Arrays and Linked Lists', 'Understanding arrays and linked lists', 'https://youtu.be/6e6yKtr2VGI?si=_ouCPb7usRiJkadb', 2),
(3, 'Stacks and Queues', 'Understanding stacks and queues', 'https://youtu.be/lAEmhJA-tVw?si=cO08fgNblW_tUQZL', 3),
(3, 'Trees and Graphs', 'Understanding trees and graphs', 'https://youtu.be/JTfPmCiLhz0?si=BzIYEH5nrT7FnGey', 4),

-- Course 4: Graphic Design Fundamentals (2 lectures)
(4, 'Introduction to Graphic Design', 'Overview of graphic design', 'https://youtu.be/e_dv7GBHka8?si=fI_EXTpCe447kQkb', 1),
(4, 'Design Principles and Elements', 'Understanding design principles and elements', 'https://youtu.be/12iPgXZz31A?si=SpYZlly7fCAe_rOP', 2),

-- Course 5: Digital Marketing Strategies (2 lectures)
(5, 'Introduction to Digital Marketing', 'Overview of digital marketing', 'https://youtu.be/ieT-OCBFwfI?si=GdzQOtqgDwQY-FvM', 1),
(5, 'SEO and Social Media Marketing', 'Understanding SEO and social media marketing', 'https://youtu.be/ieT-OCBFwfI?si=GdzQOtqgDwQY-FvM', 2),

-- Course 6: Accounting Principles (2 lectures)
(6, 'Introduction to Accounting', 'Overview of accounting principles', 'https://youtu.be/pTTyShseeTw?si=Ai4tqXQVeQ4DI2v_', 1),
(6, 'Financial Statements and Analysis', 'Understanding financial statements and analysis', 'https://youtu.be/pTTyShseeTw?si=Ai4tqXQVeQ4DI2v_', 2),

-- Course 7: Computer Science Basics (2 lectures)
(7, 'Introduction to Computer Science', 'Overview of computer science', 'https://youtu.be/FgKE9U4Tyd8?si=gW_DjJVHb-AbsoDn', 1),
(7, 'Programming Fundamentals', 'Introduction to programming', 'https://youtu.be/FgKE9U4Tyd8?si=gW_DjJVHb-AbsoDn', 2),

-- Course 8: Mathematics Fundamentals (1 lecture)
(8, 'Introduction to Mathematics', 'Overview of mathematical concepts', 'https://youtu.be/OmJ-4B-mS-Y?si=KC1c8KovUnRPsW6-', 1),

-- Course 9: Physics Essentials (3 lectures)
(9, 'Introduction to Physics', 'Overview of physics concepts', 'https://youtu.be/6akmv1bsz1M?si=ZCUzH8aegCzISlN_', 1),
(9, 'Mechanics and Thermodynamics', 'Understanding mechanics and thermodynamics', 'https://youtu.be/6akmv1bsz1M?si=ZCUzH8aegCzISlN_', 2),
(9, 'Electromagnetism and Optics', 'Understanding electromagnetism and optics', 'https://youtu.be/6akmv1bsz1M?si=ZCUzH8aegCzISlN_', 3),

-- Course 10: Chemistry Basics (3 lectures)
(10, 'Introduction to Chemistry', 'Overview of chemistry concepts', 'https://youtu.be/5iTOphGnCtg?si=ETD2770bDMgvBaYD', 1),
(10, 'Inorganic and Organic Chemistry', 'Understanding inorganic and organic chemistry', 'https://youtu.be/5iTOphGnCtg?si=ETD2770bDMgvBaYD', 2),
(10, 'Physical and Analytical Chemistry', 'Understanding physical and analytical chemistry', 'https://youtu.be/5iTOphGnCtg?si=ETD2770bDMgvBaYD', 3);


select * from [User]
select * from INSTRUCTOR
select * from COURSE
select * from ENROLLMENT
select * from REVIEW
select * from PAYMENT
select * from CONTACTFORM
select * from DISCUSSIONFORUM
select * from ASSIGNMENT
select * from [CERTIFICATE]
select * from LECTURE
