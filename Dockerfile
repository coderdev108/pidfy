# 1. Python Base Image
FROM python:3.9-slim

# 2. System Dependencies Install karein (Heavy Duty)
# 'cmake' aur 'pkg-config' add kiya hai kyunki OpenCV/Pdf2Docx ko iski zaroorat padti hai
RUN apt-get update && apt-get install -y \
    libreoffice \
    default-jre \
    build-essential \
    cmake \
    pkg-config \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libxml2-dev \
    libxslt1-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 3. Folder Set karein
WORKDIR /app

# 4. Requirements Install karein
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
# Pehle heavy libraries install karein taaki cache use ho sake
RUN pip install --no-cache-dir opencv-python-headless
RUN pip install --no-cache-dir -r requirements.txt

# 5. Code Copy karein
COPY . .

# 6. Port Expose karein
EXPOSE 5000

# 7. Server Start karein (Waitress)
CMD ["python", "server.py"]