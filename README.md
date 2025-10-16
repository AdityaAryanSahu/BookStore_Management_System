
# BookStore Management System

A full-stack application developed as a two member team for managing books, customers, and personalized recommendations built with **Flutter**, **FastAPI**, and **PostgreSQL**. The system provides a comprehensive book catalog with user authentication, wishlist management, and personalized book recommendations.

***

## Features

-  **Comprehensive Book Catalog** with detailed information (authors, categories, ratings, descriptions)
-  **Customer Authentication** system with secure login
-  **Wishlist Management** - Add/remove books from personal collections
-  **Personalized Recommendations** based on user preferences and reading history
-  **Responsive Design** - Works seamlessly on desktop and mobile
-  **Real-time API** with FastAPI auto-generated documentation
-  **Cross-Origin Support** with proper CORS handling

***

## Tech Stack

**Frontend:**

- Flutter Web (Cross-platform UI framework)
- Dart (Programming language)
- HTTP (API communication)
- Surge.sh (Static hosting)

**Backend:**

- FastAPI (Modern Python web framework)
- PostgreSQL (Database)
- Pydantic (Data validation)
- psycopg2 (Database connectivity)
- Render (Cloud hosting)

***

## How It Works

1. **User Authentication**: Customers log in using username/password authentication
2. **Browse Catalog**: Users can explore the complete book database with filtering options
3. **Wishlist System**: Books can be added to personal wishlists for later reference
4. **Smart Recommendations**: The system analyzes user preferences and suggests relevant books
5. **Real-time Updates**: All data is synchronized across the web application instantly

***

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/AdityaAryanSahu/book_management_system.git
cd book_management_system
```


### 2. Backend Setup

```bash
cd backend
python -m venv venv
venv\Scripts\activate   # On Windows
# or
source venv/bin/activate   # On macOS/Linux

pip install -r requirements.txt
```


### 3. Database Configuration

Set up your PostgreSQL database and update connection details:

```bash
export DATABASE_URL="postgresql://user:password@host:port/database"
```


### 4. Run Backend Server

```bash
uvicorn app:app --host 0.0.0.0 --port 8000 --reload
```


### 5. Frontend Setup

```bash
cd ../frontend
flutter pub get
flutter run -d chrome   # For development
# or
flutter build web --web-renderer html   # For production
```


### 6. Deploy Frontend

```bash
cd build/web
cp index.html 200.html   # For SPA routing support
npx surge
```

> **Live Demo**: [https://book_management_system.surge.sh](https://book_management_system.surge.sh)

***

## API Endpoints

- `GET /books/` - Retrieve complete book catalog
- `GET /customer-auth/{username}/{password}` - User authentication
- `POST /wishlist/` - Add books to wishlist
- `GET /wishlist/{customer_id}` - Get user's wishlist
- `GET /recommend/{customer_id}` - Get personalized recommendations
- `GET /docs` - Interactive API documentation

***

## Contributed By

**Aditya Aryan Sahu**
 [GitHub](https://github.com/AdityaAryanSahu)

**Lakshya Agarwal**
[GitHub](https://github.com/LuckyMan22-SuperMan)

---
