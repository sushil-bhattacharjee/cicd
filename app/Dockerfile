from python:3.12.3

# Copy dependency file first for caching
COPY requirements.txt /app/

# Copy the rest of the application files
COPY . /app
# Set the working directory
WORKDIR /app

RUN pip3 install -r requirements.txt
# Expose the application's port
EXPOSE 9000

# Run the application
CMD ["python3", "main.py"]