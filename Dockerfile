FROM tomcat:8.0

# File Author
MAINTAINER shivakarthik

# Define default environment variables
ENV GAMEOFLIFE_HOME=/usr/local/tomcat


# Set default directory
WORKDIR $GAMEOFLIFE_HOME

# Copy  war file
COPY ./*.war ${GAMEOFLIFE_HOME}/webapps/gameoflife-1.0.war


# Give permissions
RUN chmod 755 ${GAMEOFLIFE_HOME}/webapps/gameoflife-1.0.war

# Expose default servlet container port
EXPOSE 8080
