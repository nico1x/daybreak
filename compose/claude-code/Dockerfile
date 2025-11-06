# Use official Node.js Alpine image
FROM node:25-alpine

# Install git and su-exec (required by Claude Code and entrypoint)
RUN apk add --no-cache git su-exec

# Install Claude Code globally
RUN npm install -g @anthropic-ai/claude-code@~2.0.0