# Social Media Web Application

## Overview

This is a web application built with Ruby on Rails 7, utilizing PostgreSQL or MariaDB as the database. The application allows users to register, create text-based posts, follow each other, and view posts from users they follow in a chronological feed. Additionally, users can comment on posts, with comments organized in a threaded structure where each comment can either be a reply to the original post or another comment.

## Features

- **User Registration**: Users can sign up and log in using the Devise 4.9 library.
- **Post Creation**: Users can create and publish text-based posts.
- **Following System**: Users can follow other users.
- **Feed**: Users can view posts from those they follow in chronological order.
- **Commenting**: Users can comment on posts. Comments can be nested, allowing for threaded discussions.

## Getting Started

To get started with the Rails project, follow these steps:

1. **Clone the Repository**:
   ```sh
   git clone https://github.com/izhanov/aads_sn.git
   cd aads_sn
   ```
2. **Install Dependencies:**
  ```bundle install```
3. **Setup Database:**
  ```sh
  rails db:create
  rails db:migrate
  ```
4. **Start the Development Server:**
  ```sh
  bin/dev
  ```



