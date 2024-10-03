# Use the official MySQL image as a base
FROM mysql:latest

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Set the default user for the MySQL image
USER mysql

# Set environment variables for the new user
ENV MYSQL_USER=external_user
ENV MYSQL_PASSWORD=password
ENV MYSQL_DATABASE=my_database

# Run the following commands to create the new user and grant them the necessary permissions
RUN mysql --protocol=tcp -u root -h 127.0.0.1 -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
RUN mysql --protocol=tcp -u root -h 127.0.0.1 -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
RUN mysql --protocol=tcp -u root -h 127.0.0.1 -e "FLUSH PRIVILEGES;"

# Expose port 3306 to allow connections to the database
EXPOSE 3306

# Start the MySQL server when the container is run
CMD ["mysqld"]