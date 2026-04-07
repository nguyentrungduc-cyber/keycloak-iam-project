# Sử dụng Node.js phiên bản ổn định
FROM node:18-alpine

# Tạo thư mục làm việc trong container
WORKDIR /usr/src/app

# Sao chép package.json và package-lock.json trước để tận dụng cache của Docker
COPY package*.json ./

# Cài đặt các thư viện (dependencies)
RUN npm install

# Sao chép toàn bộ mã nguồn vào container
COPY . .

# Mở cổng 3000 (cổng mặc định của app)
EXPOSE 3000

# Lệnh khởi chạy ứng dụng
CMD ["npm", "start"]