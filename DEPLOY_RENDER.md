git add .
git commit -m "fix: Use custom Apache config for port 8080"git add .
git commit -m "fix: Simplify Dockerfile and fix Apache config order"
git push origin main# 🚀 Hướng dẫn Deploy trên Render + Docker Hub

## 📋 Yêu cầu
- Tài khoản Docker Hub (có rồi ✅)
- Tài khoản Render (render.com)
- Git repository (GitHub/GitLab)

---

## 🔧 Bước 1: Chuẩn bị Docker Hub

### 1.1 Login Docker
```bash
docker login
# Nhập username & password Docker Hub
```

### 1.2 Build & Push image
```bash
# Build image
docker build -t YOUR_USERNAME/shoes-web:latest .

# Push lên Docker Hub
docker push YOUR_USERNAME/shoes-web:latest
```

Kiểm tra: https://hub.docker.com/repositories

---

## 🌐 Bước 2: Deploy trên Render

### 2.1 Tạo Web Service trên Render
1. Vào https://render.com
2. Chọn **New** → **Web Service**
3. Chọn **Docker** (hoặc pull từ GitHub nếu code đã push)

### 2.2 Cấu hình Web Service
- **Name:** `shoes-web` (hoặc tên khác)
- **Region:** Singapore (gần Việt Nam)
- **Docker Image:** `YOUR_USERNAME/shoes-web:latest`
- **Port:** 8080
- **Plan:** Free (hoặc Paid tùy nhu cầu)

### 2.3 Thêm Environment Variables
```
DB_HOST=your-mysql-service.onrender.com
DB_USER=shoestore
DB_PASS=your_strong_password
DB_NAME=shoestore
```

### 2.4 Deploy MySQL
1. Chọn **New** → **MySQL**
2. **Name:** `shoes-db`
3. Lưu credentials

---

## 📝 Bước 3: Cập nhật docker-compose.prod.yml

Thay các biến môi trường:
```yaml
image: YOUR_USERNAME/shoes-web:latest
environment:
  - DB_HOST=shoes-db.onrender.com  # MySQL service URL
```

---

## ✅ Bước 4: Verify

Sau 5-10 phút, web sẽ online tại:
```
https://shoes-web.onrender.com
```

---

## 🔄 Cập nhật sau này

Để deploy version mới:
```bash
# Make changes locally
# Build & push new image
docker build -t YOUR_USERNAME/shoes-web:v2 .
docker push YOUR_USERNAME/shoes-web:v2

# Trên Render: Chỉnh Docker Image → Restart
```

---

## 🛡️ Security Tips
- ❌ KHÔNG public DB credentials trong code
- ✅ Dùng Render environment variables
- ✅ Enable HTTPS (Render tự động)
- ✅ Change default passwords

---

## 🆘 Troubleshoot

**Web error?**
```bash
# Xem logs trên Render: Logs → View
```

**DB connection failed?**
```bash
# Check: Render → MySQL details → Host/Port/User/Pass
```

**Image not found on Docker Hub?**
```bash
docker push YOUR_USERNAME/shoes-web:latest
# Và check privacy settings (phải public)
```

---

**Hỗ trợ:** Đặt câu hỏi nếu có vấn đề!
