# Use the official Apache HTTP Server image as a base image
FROM httpd:2.4

# Copy your custom HTML file to the appropriate directory in the container
COPY ./index.html /usr/local/apache2/htdocs/

# Expose port 80 to the outside world
EXPOSE 80

# The default command to run Apache is already set in the base image,
# so there's no need to add any CMD or ENTRYPOINT directives.