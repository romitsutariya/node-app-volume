FROM node:20

# Set the working directory
WORKDIR /usr/src/app

# Create a user with the same UID as ec2-user (usually 1000) if it doesn't already exist
RUN id -u ec2-user &>/dev/null || useradd -u 1000 -m ec2-user

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . .

# Change ownership of the application files to ec2-user
RUN chown -R ec2-user:ec2-user /usr/src/app

# Switch to the new user
USER ec2-user

# Expose the port the app runs on
EXPOSE 80

# Command to run the application
CMD ["node", "server.js"]