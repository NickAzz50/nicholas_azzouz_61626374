# Base image for Node.js
FROM node:16-bullseye AS node

RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    build-essential \
    libssl-dev \
    libffi-dev \
    libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /nextjs-app/app

COPY nextjs-app/app/package.json ./
RUN npm install

COPY nextjs-app/app/ .

RUN pip install -r /nextjs-app/app/requirements.txt

# Base image for Django
FROM python:3.10-slim AS django

RUN pip install django

WORKDIR /nextjs-app

COPY nextjs-app/app/ .

EXPOSE 3000
EXPOSE 8000
