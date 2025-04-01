# ใช้ base image ที่เหมาะสมสำหรับ Robot Framework
FROM python:3.9-slim

# ตั้งค่าพื้นที่ทำงาน
WORKDIR /opt/robotframework

# ติดตั้ง dependencies ที่จำเป็น
RUN apt-get update && \
    apt-get install -y \
    wget \
    unzip \
    chromium \
    chromium-driver \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# ติดตั้ง ChromeDriver
RUN wget -q https://chromedriver.storage.googleapis.com/$(wget -qO- https://chromedriver.storage.googleapis.com/LATEST_RELEASE)/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && rm chromedriver_linux64.zip \
    && mv chromedriver /usr/local/bin/ \
    && chmod +x /usr/local/bin/chromedriver

# ติดตั้ง Robot Framework และ libraries ที่จำเป็น
RUN pip install --no-cache-dir \
    robotframework \
    robotframework-seleniumlibrary \
    robotframework-pabot \
    selenium

# คัดลอกไฟล์ทดสอบ
COPY . /opt/robotframework/HomeTest/

# สร้างโฟลเดอร์สำหรับรายงาน
RUN mkdir -p /opt/robotframework/reports

# คำสั่งเริ่มต้นเมื่อรัน container
CMD ["robot", "--outputdir", "/opt/robotframework/reports", "/opt/robotframework/HomeTest/script.robot"]