#  Website offline

This repository contains the source code, configuration management, and scripts for my personal website which is a fullstack application built with a Next.js frontend, FastAPI Backend, is deployed on AWS using Terraform, and orchestrated via Docker and GitHub Actions. 

## Tech Stack

| **Component**      | **Tool**                |
| ------------------ | ----------------------- |
| Backend            | Python, FastAPI         |
| Frontend           | Next.js                 |
| Reverse Proxy      | NGINX                   |
| Containerization   | Docker + Docker Compose |
| IaC                | Terraform               |
| Cloud              | AWS(EC2, S3)            |
| CI/CD              | GitHub Actions          |

##  Architecture Overview

The application is deployed on a single AWS EC2 instance and runs as three Docker container services:

<pre>
                  ┌────────────┐
                  │   Client   │
                  └─────┬──────┘
                        │
   ┌────────────────────+─────────────────────┐
   │                    |             Host    │
   │                    |                     │
   │            ┌───────▼───────┐             │
   │            │ Reverse Proxy │             │
   │            └────┬──┬───────┘             │
   │                 │  │                     │
   │      ┌──────────┘  └──────────┐          │
   │ ┌────▼────────┐       ┌───────▼──────┐   │
   │ │   Backend   │       │   Frontend   │   │
   │ └─────────────┘       └──────────────┘   │
   │                                          │
   └──────────────────────────────────────────┘ 
</pre>

## Features

- Fullstack website running entirely in containers
- One-command deployment via GitHub Actions
- Infrastructure provisioned automatically with Terraform
- Secure and production-ready Docker setup
- Seamless CI/CD with automatic image build, push, and deployment
- Parallelized jobs with caching to optimize pipeline run times

## CI/CD Workflow

Every push to the `main` branch triggers:

1. Backend Docker container build
2. Frontend build and Docker container build
3. Terraform apply
4. Update and restart of services with commands sent through AWS SSM

