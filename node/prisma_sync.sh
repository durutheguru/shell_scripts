#!/bin/bash

# Run Prisma CLI command to pull schema from database
npx prisma db pull 

# Run Prisma CLI command to generate Prisma Client
npx prisma generate .
