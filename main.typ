#import "template.typ": *
#let title = "Desktop AIS"
#let author = "Illia Chaban/Artem Shtepa"
#let course = "VAVA"
#let semester = "Spring 2023"
#let due_time = "April 26"
#set enum(numbering: "1.")
#show: assignment_class.with(title, author, course, semester, due_time)


#align(
    center
)[
    = Terminology
] \
== AIS
Academic Information System - the current system used by STU to manage academic information such as student records, course materials, grades, and exam dates.

== BAIS
BetterAIS - a project designed to improve the current AIS and other STU services by providing API for current and additional functionality.

== DAIS
DesktopAIS - a desktop application designed to simplify and streamline the work with is.stuba.sk and other stuba.sk services, allowing students to access all the data they need in one place. As a backend, it uses BAIS.

== Ubytovanie
Ubytovanie - Accommodation system - a service provided by STU to manage student accommodation, allowing students to book and manage their living arrangements.

#pagebreak()

#align(
    center
)[
    = Introduction
] \

DAIS - DesktopAIS, a centralized application designed to simplify and streamline the work with is.stuba.sk and other stuba.sk services for students and teachers at the Slovak University of Technology in Bratislava (STU).  

The current STU system lacks a centralized platform for its services, resulting in various problems such as interface issues, content layout problems, and missing necessary functionality in some services. DAIS aims to solve these problems by providing a user-friendly interface that allows students to access and manage all their academic information in one place.  

In this project, we have implemented various features such as login to STU, viewing assignments and timetables, accessing information from the accommodation system, generating ScanToPay for accommodation system, and switching light/dark themes. Additionally, we have incorporated important requirements such as logging, localization, XML processing, regular expressions, JDBC, input treatment/validation, and GUI application design.  

As a proof of concept (POC), we believe that DAIS has the potential to simplify and streamline the academic process for the STU community, making it easier for students and teachers to manage their academic information. While this project is not yet fully developed, we anticipate that it could provide significant benefits if implemented successfully.  

#pagebreak()

= Vision
DAIS aims to simplify and streamline the work with is.stuba.sk and other stuba.sk
services. It allows students to get all the data they need in one place and doesn't
discourage new students.

= Usage Scenario
Currently stuba.sk has no centralized system for its services. Services such as
cvt.stuba.sk, is.stuba.sk have problems with the interface. It takes a long time for
students entering STU to get used to AIS. There are big problems with the layout of
content in the application. Services like ubytovanie.stuba.sk miss even basic and
necessary functionality. The audience of our product is students and teachers. We do
not take responsibility for submitting assignments, publishing assignments, etc. At
the moment it is only a proxy in AIS and Ubytovanie with an improved interface.

= Our Customers
DAIS is an application designed to simplify and streamline the work with is.stuba.sk
and other stuba.sk services. The users that will interact with the application can be
classified based on various criteria. Let's explore some of the major roles of users
and classify them based on different criteria:

== Students:

The primary users of DAIS are students who need to access academic information
such as their timetable, exam dates, grades, and course materials. The drivers for
students to use DAIS are to easily access and manage their academic information,
stay upto-date with their coursework, and track their progress. The number of users
for students is relatively high as DAIS is designed for all students at STU. The time
spent in the application varies from user to user depending on their academic
workload, but on average, students may spend around 1-2 hours per week on the
application. The frequency of use is also high, with students accessing the
application daily or weekly to check for updates on their academic progress. In terms
of business knowledge, students are expected to have a basic understanding of the
academic system and procedures at STU.

== Teachers #text(size: 0.7em)[(Conception)]:
Teachers are not the main, but also an important audience for the product. We have
nothing to offer teachers at the moment, as the project is not an alternative or
replacement for AIS at the moment. Perhaps teachers can view the progress of their
students. On average, they can spend up to an hour a month in the app.

#pagebreak()
#align(
    center
)[
    = Features
] \

== User authentication and authorization
Allow users to log in securely to access their information.

== Session storage
The user session is stored in the file bais.db. Database: sqlite. The session has: access/refresh tokens, language, theme. Access to the session's db is provided through JDBC. Writing and reading data does not require escaping as jwt tokens by definition do not have `\` or `'` characters and themes have code names as well as languages. 

== Using XML
XML is an integral part of the project, since all (partly manually) templates for JavaFX are written in FXML format. 

== Data retrieval
All the work with authorization and data retrieval has been moved to BAIS. We use okHttp for http/s requests. Regex checks that weername is spelled correctly before sending the login data. All data from BAIS is in Json format and then converted into Java structures. Often there is a need for LinkedList or HashMap structures.

== Logs
For logs we use the library log4j. We liked it because it is easy to use and configure. Since the project is a POC state, DEBUG mode is enabled by default.

== System security
it depends on the ssl certificate, no system can be protected against MITM. In BAIS the data is stored safely. \
#emph[
    A little more detail about data storage in BAIS. BAIS does not store passwords/logins in a database. Every time a cluster is started with BAIS, a unique encryption token is created. when a person sends a password/login, BAIS encrypts it and puts it into a jwt_token. At first glance -- it looks like a *security issue*. But in fact it's not. First, this way, if there is a problem with the server, all jwt tokens become invalid and all data in jwt tokens become garbage. In addition -- we get a situation where the BAIS doesn't store passwords/login, but when a user asks for content from STU services, server can access his account.
]

== Localization 
2 languages are available at the moment: `sk` and `en`. A language switch is provided in the UI. The Resource Bundle determines the system language by itself. Since the selected localization is stored in a session, in the future, the UI may get the necessary functionality to change the language.

== UI
As stated earlier, the GUI lib: JavaFX is used.

#pagebreak()
#align(
    center
)[
    = Architecture
] \

#align(
    center
)[
    == ER Diagram
] \
#align(
    center
)[
    #image("res/erd.png")
]
#pagebreak()

#align(
    center
)[
    == Sequence User/App/Server
] \
#align(
    center
)[
    #image("res/sequence_user_app.png")
]
#pagebreak()

#align(
    center
)[
    == Usecase Student
] \
#align(
    center
)[
    #image("res/usecase_student.png")
]
#pagebreak()

#align(
    center
)[
    == Usecase Teacher #text(size: 0.7em)[(Conception)]
] \
#align(
    center
)[
    #image("res/usecase_teacher.png")
]
#pagebreak()

#align(
    center
)[
    == Class Diagram
] \
#align(
    center
)[
    #image("res/class_diagram.jpeg")
]
#pagebreak()

#align(
    center
)[
    == Scene
] \
#align(
    center
)[
    #image("res/scene.drawio.png")
]
