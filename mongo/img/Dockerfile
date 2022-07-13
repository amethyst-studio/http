FROM mongo:5

# Build the 'redis-server' runtime.
COPY './conf.d/mongod.conf' '/mongod.conf'

# Ensure the ability to access the file to Mongo.
RUN chmod -R 777 '/mongod.conf'