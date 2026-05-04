# 🛍️ ShoeStore - Website Bán Giày Trực Tuyến
Dự án xây dựng một website thương mại điện tử bán giày với các chức năng cơ bản:
- 👟 Quản lý sản phẩm, danh mục, hình ảnh và biến thể (size, màu)
- 🛒 Giỏ hàng, thêm/xóa/sửa số lượng sản phẩm
- 💳 Quản lý đơn hàng, thanh toán (COD, BANK, BALANCE)
- 🎟️ Hỗ trợ mã giảm giá (Coupons)
- 👤 Quản lý tài khoản người dùng (đăng ký, đăng nhập, phân quyền admin/user)
- 📩 Liên hệ qua form hỗ trợ khách hàng
- 📊 Thống kê và quản lý trong giao diện quản trị
## Công nghệ sử dụng
- **Backend:** PHP (thuần)
- **Frontend:** HTML, CSS, Bootstrap 5, JavaScript, jQuery, AJAX
- **Database:** MySQL
- **Other:** Responsive Design, Utility Classes của Bootstrap

## Docker
Dự án đã hỗ trợ chạy bằng Docker với `Dockerfile` và `docker-compose.yml`.

### Cài đặt Docker
1. Cài Docker Desktop cho Windows.
2. Bật `Docker Engine`.

### Chạy ứng dụng bằng Docker
1. Mở terminal tại thư mục gốc dự án (`c:\xampp\htdocs\shoes`).
2. Chạy:
   ```bash
   docker compose up --build
   ```
3. Mở trình duyệt và truy cập:
   - `http://localhost:8080` để vào website.
   - `mysql://root:rootpass@localhost:3306` nếu cần truy cập MySQL.

### Dừng dịch vụ
```bash
docker compose down
```

### Khởi tạo lại database
Nếu muốn xóa dữ liệu và tạo lại database từ đầu:
```bash
docker compose down -v
docker compose up --build
```

### Biến môi trường kết nối database
File `configs/db.php` đã được chuyển sang dùng biến môi trường:
- `DB_HOST`
- `DB_USER`
- `DB_PASS`
- `DB_NAME`

Trong `docker-compose.yml`, MySQL được cấu hình với:
- user: `shoestore`
- password: `shoestorepass`
- database: `shoestore`
- root password: `rootpass`

## 🚀 Deployment (Docker Hub + Render)

### Push lên Docker Hub
```bash
docker login
docker build -t YOUR_USERNAME/shoes-web:latest .
docker push YOUR_USERNAME/shoes-web:latest
```

### Deploy trên Render
Chi tiết hướng dẫn: xem [DEPLOY_RENDER.md](DEPLOY_RENDER.md)

Tóm tắt:
1. Tạo Web Service trên Render (pull image từ Docker Hub)
2. Tạo MySQL service trên Render
3. Config environment variables
4. Deploy!

Web sẽ tự động online tại: `https://shoes-web.onrender.com`
