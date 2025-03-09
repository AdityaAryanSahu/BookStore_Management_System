# BookStore Management System
# Overview
- Developed as part of a two-member team, focusing on backend development while also contributing to frontend implementation.
- The Bookstore Management System is a full-stack application designed to manage book listings, user wishlists, and personalized recommendations. It leverages PostgreSQL, FastAPI, and Flutter to create a seamless experience for users to browse books, add them to wishlists, and receive tailored recommendations.

# Features
1. User Authentication – Secure login and account management.
2. Book Catalog – Browse books with details such as author, publisher, and ratings.
3. Wishlist Functionality – Users can add books to their wishlist for future reference.
4. Personalized Recommendations – Uses database queries to suggest books based on user preferences.
5. Database Management – Structured in BCNF normalization for efficiency.
6. Stored Procedures & Triggers – Automates wishlist tracking and recommendation generation.

# Tech Stack
- Backend: FastAPI (Python)
- Frontend: Flutter (Cross-platform UI)
- Database: PostgreSQL (Hosted on Neon)
- Query Optimization: PL/SQL procedures, triggers

# Installation and Setup
- Python 3.8+ & FastAPI
- PostgreSQL installed (or use Neon for cloud hosting)
- Flutter SDK for frontend

# Steps to Run the Application
1. Clone the repository
    ```
    git clone https://github.com/AdityaAryanSahu/BookStore_Management_System.git
    cd BookStore_Management_System
    ```
2. Set up the Backend
   ```
   cd backend
   pip install -r requirements.txt
   uvicorn main:app --reload
   ```
3. Set up the Frontend
   ```
   cd frontend
   flutter pub get
   flutter run
   ```

# Database Schema 
The project follows BCNF-normalized database design with tables for books, users, wishlists, and recommendations. It includes PL/SQL procedures and triggers to automate wishlist updates and recommendation generation.
# Conclusion
The Bookstore Management System is a scalable and efficient solution for managing books, user wishlists, and recommendations. By combining FastAPI, PostgreSQL, and Flutter, this project demonstrates full-stack development skills, focusing on database integrity, query optimization, and user experience.
