# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Plan & Review
### Before starting work
- Always start in plan mode to make a plan
- After generating the plan, make sure you Write the plan to .claude/tasks/TASK_NAME.md.
- The plan should be a detailed implementation plan and the reasoning behind them, as well as tasks broken down.
- If the task requires external knowledge or certain package, also research to get latest knowledge (Use Task tool for research)
- Don't over plan it, always think MVP.
- Once you write the plan, firstly ask me to review it. Do not continue until I approve the plan.

### While implementing
- You should update the plan as you work.
- After you complete tasks in the plan, you should update and append detailed descriptions of the changes you made, so following tasks can be easily hand over to other engineers.

## Project Overview

Daybreak is a full-stack portfolio application demonstrating advanced proficiency in modern web development. Built with Next.js 16 for the frontend and Django 5 for the backend, it runs in a containerized environment orchestrated with Docker Compose. The application showcases scalable architecture, real-time interactivity, and distributed systems design.

**Key Features:**
- **Social Media Feed:** Dynamic feed with engagement-based ranking (likes, comments, shares) weighted by time decay for trending content
- **Post Scheduling:** Asynchronous job management for delayed publishing using Celery
- **Real-Time Chat and Notifications:** WebSocket-based messaging with instant updates
- **User Profile System:** Customizable profiles with authentication and authorization

**Technology Stack:**
- Frontend: Next.js 16 (App Router), React 19, TypeScript, Tailwind CSS 4
- Backend: Django 5.2.7, Python 3.13, PostgreSQL 17, Redis 8, Celery (background tasks)
- Real-time: WebSocket, Pub/Sub
- Package Managers: `uv` (Python), `yarn` (Node.js)

## Essential Commands

### Starting the Application

```bash
# Start all services (from project root or compose directory)
cd compose
docker compose up -d

# View logs
docker compose logs -f [service_name]

# Stop all services
docker compose down
```

**Access Points:**
- Frontend: http://localhost:3030
- Backend: http://localhost:8001
- Django Admin: http://localhost:8001/admin (credentials: admin/admin)

### Frontend Development (Next.js)

```bash
# Lint
docker compose exec frontend yarn lint

# Build for production
docker compose exec frontend yarn build

# Install new package
docker compose exec frontend yarn add <package>

# Run from host (if not using containers)
cd frontend
yarn dev          # Development server
yarn build        # Production build
yarn start        # Start production server
```

**Key Files:**
- `frontend/src/app/page.tsx` - Home page component
- `frontend/src/app/layout.tsx` - Root layout with fonts and metadata
- `frontend/next.config.ts` - Next.js configuration
- `frontend/tsconfig.json` - TypeScript configuration with `@/*` path alias

### Backend Development (Django)

```bash
# Run Django management commands
docker compose exec backend uv run manage.py <command>

# Common management commands
docker compose exec backend uv run manage.py makemigrations
docker compose exec backend uv run manage.py migrate
docker compose exec backend uv run manage.py createsuperuser
docker compose exec backend uv run manage.py shell

# Lint with Ruff
docker compose exec backend uv run ruff check .
docker compose exec backend uv run ruff format .

# Install new package
docker compose exec backend uv add <package>

# Run from host (if not using containers)
cd backend
uv run manage.py runserver
```

**Key Files:**
- `backend/config/settings.py` - Django settings (environment-based configuration)
- `backend/config/urls.py` - URL routing (API endpoints, admin interface)
- `backend/config/celery.py` - Celery configuration for background tasks
- `backend/pyproject.toml` - Python dependencies managed by uv

### Background Tasks (Celery)

```bash
# Monitor Celery workers (if running)
docker compose logs -f celery

# Inspect active tasks
docker compose exec backend uv run celery -A config inspect active

# Purge all tasks from queue
docker compose exec backend uv run celery -A config purge
```

### Database Access

```bash
# Access PostgreSQL shell
docker compose exec postgres psql -U daybreak -d daybreak

# Connection details
Host: localhost (or 'postgres' from within Docker network)
Port: 5432
Database: daybreak
User: daybreak
Password: p4ssw0rd
```

### Redis Access

```bash
# Access Redis CLI
docker compose exec redis redis-cli
```

## Architecture Overview

### Directory Structure

```
/project/
├── backend/              # Django application
│   ├── config/          # Django project configuration
│   │   ├── settings.py  # Main settings (uses django-environ)
│   │   └── urls.py      # URL routing
│   ├── manage.py        # Django management script
│   └── pyproject.toml   # Python dependencies (uv format)
├── frontend/            # Next.js application
│   ├── src/app/         # Next.js App Router
│   │   ├── layout.tsx   # Root layout
│   │   ├── page.tsx     # Home page
│   │   └── globals.css  # Global styles with Tailwind
│   ├── package.json     # Node.js dependencies
│   └── next.config.ts   # Next.js configuration
└── compose/             # Docker orchestration
    ├── docker-compose.yml
    ├── backend/         # Backend container config
    ├── claude-code/     # Claude Code container config
    └── db/              # Database initialization
```

### Service Dependencies

The Docker setup defines service dependencies:
- `frontend` depends on `backend`
- `backend` depends on `postgres` and `redis`

This ensures containers start in the correct order.

### Django Configuration Pattern

The backend uses a "config" pattern where the main Django project is named "config" (located in `backend/config/`). This is a common modern Django convention.

**Environment Variables:**
Django settings are configured via environment variables (django-environ). Default values are set in `docker-compose.yml`, but can be overridden with:
- `/project/.envs/.backend.env` (optional, gitignored)
- `/project/.envs/.frontend.env` (optional, gitignored)

### Frontend Routing

Next.js 16 uses the App Router (not Pages Router):
- Routes are defined by directory structure in `src/app/`
- `layout.tsx` defines the root layout with Google Fonts (Geist Sans/Mono)
- TypeScript path alias `@/*` maps to `./src/*`

### Container-Based Development

All services run in Docker containers with volume mounts for live code reloading:
- Frontend: Auto-installs dependencies on startup via `yarn run dev`
- Backend: Auto-runs migrations and creates admin user on first startup
- Both support hot reload without container rebuilds

**Non-root Containers:**
- Backend runs as UID/GID 999 for security
- Claude Code container maps to host user UID/GID dynamically

### Package Management

**Python (Backend):**
- Uses `uv` (Astral's modern package manager)
- Dependencies in `pyproject.toml`
- Lock file: `uv.lock`
- Add packages: `uv add <package>`
- Run commands: `uv run <command>`

**Node.js (Frontend):**
- Uses `yarn`
- Dependencies in `package.json`
- Lock file: `yarn.lock`

## Current State

This is a portfolio application showcasing full-stack development capabilities.

TODO Features:

- [ ] **Social Media Feed:** Engagement-based ranking algorithm with time decay
- [ ] **Post Scheduling:** Celery-based asynchronous task processing
- [ ] **Real-Time Features:** WebSocket integration for chat and notifications
- [ ] **User System:** Authentication, authorization, and profile management

**Infrastructure Ready:**
- Database with pgcrypto extension installed
- Redis for caching, sessions, and Celery task queue
- Hot reload configured for both frontend and backend
- Linting tools configured (ESLint + Prettier for frontend, Ruff for backend)
- Background task processing with Celery workers

**Authentication & Authorization**
- User/client session is handled by Firebase token verified in the backend via Firebase Admin SDK and managed by Django user sessions.
- API calls use JWT.

## Development Workflow

### ⚠️ CRITICAL: Git Workflow Requirements

1. **ALWAYS create a feature branch BEFORE making changes**
   ```bash
   git checkout -b feature/[feature-name] # or fix/[bug-name]
   ```

2. **Commit changes REGULARLY during development**
   - After completing each major step
   - When switching different files/features
   - Before running build tests

3. **NEVER work directly on main branch**
   - All changes must go through feature branches
   - Create pull requests for review

4. **Commit message format**:
   - Restrict Subject Line Length to 50 Characters
   - Use [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/) as reference
   - Example:
   ```bash
   git commit -m "fix: prevent racing of requests
   
   Introduce a request id and a reference to latest request. Dismiss incoming responses other than from latest request.
   
   Remove timeouts which were used to mitigate the racing issue but are obsolete now.

   Generated with [Claude Code](https://claude.ai/code)

   Co-Autored-By: Claude <noreply@anthropic.com>"
   ```

**Failure to follow Git workflow = Incomplete task**

---

### Adding New Features

1. **Backend API Endpoints:**
   - Create Django apps: `docker compose exec backend uv run manage.py startapp <app_name>`
   - Define models in `<app_name>/models.py`
   - Create migrations: `docker compose exec backend uv run manage.py makemigrations`
   - Apply migrations: `docker compose exec backend uv run manage.py migrate`
   - Add URL routes in `backend/config/urls.py`

2. **Frontend Pages/Components:**
   - Add routes by creating directories in `src/app/`
   - Each route needs a `page.tsx` file
   - Use TypeScript for all components
   - Import paths: Use `@/` alias (e.g., `import { foo } from '@/lib/utils'`)

### Bootstrap Process

**Backend entrypoint** (`compose/backend/entrypoint.sh`):
- Checks if admin superuser exists
- If not: runs migrations and creates admin user (username: admin, password: admin)
- Starts Django development server on 0.0.0.0:8001

**Database initialization** (`compose/db/init/init.sh`):
- Installs pgcrypto extension on first startup

### Persistent Data

Docker volumes preserve data across container restarts:
- `postgres_data` - Database files
- `redis_data` - Redis persistence

To reset: `docker compose down -v` (WARNING: deletes all data)
