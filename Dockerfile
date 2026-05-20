# Use official lightweight Node.js image
FROM node:18-alpine

# Security: Run as non-root user (least privilege principle)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set working directory
WORKDIR /app

# Copy dependency files first (layer caching optimization)
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy application source
COPY index.js .

# Change ownership to non-root user
RUN chown -R appuser:appgroup /app

# Switch to non-root user
USER appuser

# Expose application port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget -qO- http://localhost:3000/health || exit 1

# Start the application
CMD ["node", "index.js"]
