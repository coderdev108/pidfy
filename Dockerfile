# 1. Python Base Image
FROM python:3.9-slim

# 2. System Dependencies (Fixed for Render Free Tier)
# - Changed 'libgl1-mesa-glx' to 'libgl1' (Fixes package not found error)
# - Added '--no-install-recommends' to reduce download size and RAM usage
RUN apt-get update && apt-get install -y --no-install-recommends \
    libreoffice \
    default-jre \
    build-essential \
    cmake \
    libgl1 \
    libglib2.0-0 \
    libxml2-dev \
    libxslt1-dev \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# 3. Set Working Directory
WORKDIR /app

# 4. Upgrade Pip first (Important for newer libraries)
RUN pip install --no-cache-dir --upgrade pip

# 5. Install Python Libraries
COPY requirements.txt .

# Pehle OpenCV Headless install karein (sabse bhari library)
RUN pip install --no-cache-dir opencv-python-headless

# Phir baaki sab install karein
RUN pip install --no-cache-dir -r requirements.txt

# 6. Copy Code
COPY . .

# 7. Expose Port
EXPOSE 5000

# 8. Start Command
CMD ["python", "server.py"]