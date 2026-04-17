## 🚀 Running the Application
- **Dependencies:** Configure your preferred data source or use the default H2 database.  
- **Application Properties:** Provide the necessary API keys and secret credentials before running the application.  

---

## 📌 Overview  
This project was developed as part of a second-year, second-semester group software engineering module. The objective was to create an integrated learning platform utilising Selenium for browser-based functionality. The project followed **Agile Scrum methodology**, simulating a real-world development environment with collaborative teamwork, iterative development, and fixed deadlines.

---

## 🛠️ Tech Stack  

**Frontend:**  
- HTML, CSS, Bootstrap, JavaScript, TypeScript, JSP  

**Backend:**  
- Java, Spring Boot (MVC), REST APIs  
- H2 Database  
- OAuth integration (Google, GitHub)  
- External APIs (GenAI, ElevenLabs)  

---

## 👥 Team Contributions  

- **Member 1:** Text-to-Speech functionality using ElevenLabs API and JavaScript-based text extraction (not merged into final build).  
- **Member 2:** Authentication system (Login/Register), OAuth integration (Google, GitHub), admin comment management, ratings, and comments.  
- **Member 3:** Rewards system (badges), course completion tracking, goal setting, and time tracking (start/finish).  
- **Member 4:** Personalised statistics using GenAI API, automated dashboard content, dashboard development, and leaderboard implementation.  
- **Member 5:** Daily streak system, course search and filtering, trending courses, and notifications.  
- **Member 6:** Admin messaging inbox and user feedback system.  

---

## 👤 Individual Contribution  

As **Member Seven**, I was responsible for implementing core user and social features:

- **Account Management:** View, update, and delete account details.  
- **Friends System:** View, search, and remove friends, along with profile privacy controls.  
- **User Profile:** View and customise user profiles.
- **Guild System:** View guilds, Join guilds, Guild privacy, Edit Guild member / bio / announcement / delete, Guild leaderboard.

---

## 🏰 Guild System  

The **Guild system** was a key and complex feature designed to support user collaboration and competition.

### Core Functionality  
- **Guild Joining:**  
  - Public guilds can be joined directly via a button.  
  - Private guilds require an invite code.  

- **Guild Profile:**  
  - Customised interface displaying:
    - Total guild points  
    - Member list with individual scores  
    - Member roles  
  - Options to leave or manage the guild  

---

## 🧩 Role Management  

Three hierarchical roles were implemented:

- **MASTER (Owner):**  
  - Full control over guild management  
  - Can edit guild settings and roles  
  - Cannot leave the guild  

- **CAPTAIN:**  
  - Can view invite code  
  - Cannot edit guild settings  
  - Can leave the guild  

- **ROOKIE:**  
  - Default role  
  - Cannot view invite code  
  - Can leave the guild  

---

## 🏆 Leaderboard System  
- Integrated a **guild leaderboard** alongside the individual user leaderboard.  
- Users must join a guild to participate.  
- Guild points are dynamically updated based on user activity.  
- Changes are reflected instantly using repository and model-layer logic.  

---

## ⚙️ Guild Management  
- Guild Masters can:
  - Edit guild name, description, and announcements  
  - Promote members (including transferring ownership)  
  - Delete the guild  

- **Guild Deletion:**  
  - Instantly removes the guild from the system  
  - Updates all related data, including leaderboard entries, in real time  

---

## 📈 Final Reflection  
This project provided valuable experience in applying Agile Scrum practices within a team environment, improving both collaborative development skills and technical proficiency in full-stack application design.
