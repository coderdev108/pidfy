# 1. Python का हल्का-फुल्का वर्जन इस्तेमाल करें
FROM python:3.9-slim

# 2. सिस्टम अपडेट करें और LibreOffice + Java इनस्टॉल करें
# (Java, LibreOffice को चलाने के लिए जरूरी है)
RUN apt-get update && apt-get install -y \
    libreoffice \
    default-jre \
    && rm -rf /var/lib/apt/lists/*

# 3. वर्किंग डायरेक्टरी सेट करें
WORKDIR /server

# 4. requirements.txt कॉपी करें और लाइब्रेरीज़ इनस्टॉल करें
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 5. बाकी सारा कोड कॉपी करें
COPY . .

# 6. पोर्ट 5000 खोलें (जहां Flask/Waitress चलेगा)
EXPOSE 5000

# 7. सर्वर स्टार्ट कमांड (Production Ready)
CMD ["python", "server.py"]