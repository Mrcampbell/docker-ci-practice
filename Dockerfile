# Multi-step Build Process

# Build Phase
FROM node:alpine as builder
WORKDIR $HOME/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Run Phase
# NOTE: adding a new FROM changes the base image from before
FROM nginx 

# Copy over only the important stuff from the last phase
# only the build dir, leaving node and src code behind.
COPY --from=builder /app/build /usr/share/nginx/html