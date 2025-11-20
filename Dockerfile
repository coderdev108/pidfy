FROM python:3.9-slim

# 2. System Dependencies Install karein
# - libreoffice: Word/PPT to PDF ke liye
# - default-jre: LibreOffice ke liye Java
# - build-essential: Python libs (jaise lxml, pdf2docx) ko compile karne ke liye (GCC/C++)
# - libgl1 & libglib2.0-0: Image processing aur OpenCV ke liye zaroori
# - libxml2-dev & libxslt1-dev: python-pptx ke liye zaroori

RUN apt-get update && apt-get install -y \
    libreoffice \
    default-jre \
    build-essential \
    libgl1 \
    libglib2.0-0 \
    libxml2-dev \
    libxslt1-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 3. Folder Set karein
WORKDIR /app

# 4. Requirements Install karein
# Pehle requirements copy karein taaki Docker cache use kar sake
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# 5. Code Copy karein
COPY . .

# 6. Port Expose karein
EXPOSE 5000

# 7. Server Start karein (Waitress)
CMD ["python", "server.py"]