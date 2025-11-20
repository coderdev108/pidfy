# 1. Python Base Image
FROM python:3.9-slim

# 2. System Dependencies (Heavy Duty Fix)
# - pkg-config: Ye sabse zaroori hai (Error fix karne ke liye)
# - libcairo2-dev: Graphics libraries ke liye zaroori
# - python3-dev: Headers ke liye
RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    default-jre \
    build-essential \
    cmake \
    pkg-config \
    libcairo2-dev \
    libgl1 \
    libglib2.0-0 \
    libxml2-dev \
    libxslt1-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 3. Set Working Directory
WORKDIR /server

# 4. Upgrade Pip (Important)
RUN pip install --no-cache-dir --upgrade pip

# 5. Install Python Libraries
COPY requirements.txt .

# Pehle OpenCV Headless install karein (heavy hai)
RUN pip install --no-cache-dir opencv-python-headless

# Phir baaki sab
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy Code
COPY . .

# 7. Expose Port 7860 (Hugging Face ke liye) or 5000 (Render ke liye)
# Render port environment variable use karta hai, lekin hum 5000 expose karenge
EXPOSE 5000

# 8. Start Command
CMD ["python", "server.py"]