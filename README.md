# 🚔 Crime File Management System (PostgreSQL + UI)

## 📌 Overview
The **Crime File Management System** is a database-driven application that manages records of crimes, suspects, FIRs, and police officers.  
It supports **advanced search**, **views**, and **triggers** for logging updates, and features a user interface for easy interaction.

---

## 🗂 Features
- 📝 Manage **Crimes**, **FIRs**, **Suspects**, and **Police Officers**
- 🔍 **Advanced Search** by location, type, and date
- 🛠 **Views & Triggers** for logging and analytics
- 📊 **Reports** with aggregate queries and joins
- 💻 UI to interact with the PostgreSQL database

---

## 📐 ER Diagram
The system is based on an **ER Model** with:
- **Entities:** Crime, Suspect, Police Officer, FIR (weak entity)
- **Relationships:** Crime–FIR, Suspect–FIR, Police Officer–FIR
- **Cardinalities:** One crime can have many FIRs, one FIR belongs to one crime, etc.

---

## 📑 Database Schema
**Tables:**
- `crimes(crime_id, type, location, date, description, status)`
- `suspects(suspect_id, name, gender, dob, address)`
- `police_officers(officer_id, name, rank, station)`
- `firs(fir_id, crime_id, suspect_id, officer_id, fir_date, details)`

---

## ⚙️ Technologies Used
- **Database:** PostgreSQL
- **UI:** HTML/CSS + JavaScript or Python Flask (based on preference)
- **SQL Features:** Joins, Views, Triggers, Aggregate Functions
