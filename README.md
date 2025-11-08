# Daybreak

## Overview
This project is a full-stack portfolio application developed to demonstrate advanced proficiency in modern web development. Built with **Next.js 16** for the frontend and **Django 5** for the backend, it runs in a **containerized environment using Docker and orchestrated with Docker Compose**. The system architecture highlights clean separation of concerns, scalability, and real-time interactivity across distributed services.

## Key Features
- **Social Media Feed:**  
  A dynamic feed that allows users to share, view, and interact with posts in real time.
  Ranking based on engagement metrics (likes, comments, shares) weighted by time decay, ensuring that trending content remains fresh and relevant.

- **Post Scheduling:**
  Scheduled posts to be published as specific times, demonstrating asynchronous job management, delayed publishing, and distributed task orchestration.

- **Real-Time Chat and Notifications:**  
  Integrated messaging system with instant updates and push notifications, showcasing event-driven and asynchronous communication.

- **User Profile System:**  
  Customizable user profiles that highlight authentication, data management, and responsive UI implementation.

## Technical Highlights
This project demonstrates expertise in:
- Designing and developing scalable full-stack architectures with modular, maintainable codebases.
- Implementing real-time communication using WebSocket and Pub/Sub for instant messaging and live updates.
- Developing and optimizing algorithmic features such as a **trending post ranking system** — where posts in the feed are dynamically sorted based on user engagement metrics (likes, comments, shares) weighted by time decay to ensure fresh and relevant content surfaces first.
- Implementing background tasks processing for asynchronous job management.
- Applying modern frontend frameworks and RESTful API design principles for efficient data handling and seamless user interactions.
- Managing secure authentication, authorization, and data persistence across both client and server environments.
- Delivering intuitive and responsive user experiences with a focus on performance, accessibility, and scalability.

## Purpose
The project serves as a professional portfolio piece, showcasing mastery of end-to-end development workflows, system integration, and industry best practices. It highlights the ability to conceptualize, design, and implement production-grade web applications while reflecting a deep understanding of distributed systems, scalable architectures, real-time communication, and developer-centric workflows.

## Stack Summary
> React • Next.js • TypeScript • Django • PostgreSQL • Redis • Celery • Docker • Tailwind CSS • WebSocket • uv • Yarn

---

## Run the project

### Run the containers
```bash
$ cd compose
$ docker compose up -d
```

---

### Run and attach claude-code
```bash
$ cd compose
$ docker compose up -d claude-code && docker compose attach claude-code
```

Login as required

---

### View in browser

NextJS at `localhost:3030`

Django at `localhost:8001`