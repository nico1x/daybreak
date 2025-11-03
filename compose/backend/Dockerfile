FROM python:3.13-bookworm

ARG APP_HOME=/app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_LINK_MODE=copy \
    UV_PYTHON_DOWNLOADS=never \
    UV_PROJECT_ENVIRONMENT=${APP_HOME}/.venv


# install uv from astral's image
COPY --from=docker.io/astral/uv:0.9 /uv /uvx /bin/

# copy lock files
COPY ./backend/pyproject.toml ./backend/uv.lock /_lock/

# Synchronize dependencies.
# This layer is cached until uv.lock or pyproject.toml change.
RUN --mount=type=cache,target=/root/.cache \
    cd /_lock && \
    uv sync \
    --frozen \
    --no-install-project

RUN apt-get update && apt-get install --no-install-recommends -y \
  # dependencies for building Python packages
  build-essential \
  # psycopg dependencies
  libpq-dev \
  gettext \
  wait-for-it

# Setup a non-root user
RUN groupadd --system --gid 999 nonroot \
 && useradd --system --gid 999 --uid 999 --create-home nonroot

# Place executables in the environment at the front of the path
ENV PATH="/${APP_HOME}/.venv/bin:$PATH"

# Use the non-root user to run our application
USER nonroot

WORKDIR ${APP_HOME}