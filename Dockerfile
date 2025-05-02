FROM openjdk:17-jdk-slim

# Install tools: xvfb for headless display, x11-utils and imagemagick for screenshot
RUN apt-get update && \
    apt-get install -y xvfb x11-apps imagemagick libxext6 libxrender1 libxtst6 maven && \
    apt-get clean

WORKDIR /app
COPY . .

# Build the Java project (this compiles RunDemo.java)
RUN mvn clean package

# Start Xvfb + Run the GUI app + wait + take screenshot
ENTRYPOINT bash -c "Xvfb :99 -screen 0 1280x1024x24 & \
  export DISPLAY=:99 && \
  java -jar target/twig-0.0.4-core.jar & \
  sleep 10 && \
  import -display :99 -window root /app/output/twig_demo.png && \
  echo 'Image saved to /app/output/twig_demo.png'"
