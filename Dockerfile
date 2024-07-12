# Use the Dart SDK base image
FROM dart:stable

# Set the working directory
WORKDIR /app

# Copy the Dart server script into the container
COPY . .

# Ensure all dependencies are installed (if any)
RUN dart pub get

# Expose the port the server will run on
EXPOSE 8080

# Define the command to run the server
CMD ["dart", "my_server.dart"]
