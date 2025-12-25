# --- Stage 1: The Builder ---
# Use a Python image to run the script
FROM python:3.9-slim AS builder
WORKDIR /app
COPY app.py .
# Run the python script to generate index.html
RUN python app.py

# --- Stage 2: The Server ---
# Use a lightweight Nginx image to serve the file
FROM nginx:alpine
# Copy only the generated index.html from the Builder stage
COPY --from=builder /app/index.html /usr/share/nginx/html/index.html
EXPOSE 80