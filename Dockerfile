# Use a lightweight base image with SSH installed
FROM alpine:latest

# Install OpenSSH client and autossh for reliable SSH tunneling
RUN apk add --no-cache openssh-client autossh

# Set the working directory
WORKDIR /app

# Copy the startup script
COPY start.sh .

# Make the startup script executable
RUN chmod +x start.sh

# Set the default command to run the startup script
CMD ["./start.sh"]
