## ChatGPT App Ruby

Project demo về chatGPT cho việc Q&A

### Technologies:

1. Fontend
  a. HTML
  b. CSS
  c. JS

2. Backend (NodeJS)
  a. ExpressJS
  b. Cors
  c. OpenAI API

3. Backend (Ruby Sinatra)
  a. Sinatra
  b. Puma
  c. OpenAI API
  d. Ruby 3.2

### Start App

#### Client

```bash
cd javascripts

npm install # Cài đặt thư viện

npm run dev # Khởi chạy với môi trường phát triển

npm run build # Đóng gói thành các file tĩnh

npm run preview # Khởi chạy server để truy cập các file tĩnh sau khi build
```

#### Server NodeJS

```
cd javascripts

node server.js # Khởi chạy server
```

#### Server Ruby on Sinatra

**Install libraries**
```
bundle install --path vendor/bundle
```

**For environment development**

```
bin/server

# or

bundle exec rackup config.ru -E development -p 3000

# or

bundle exec puma -e development -C config/puma.rb
```

**For environment production**

```
bundle exec rackup config.ru -E production -p 3000

# or

bundle exec puma -e production -C config/puma/production.rb
```

#### Deployment

**For Client**

```
cd javascripts

npm run deploy # It will build and deploy

npm run only-deploy # It will only deploy not build
```

**For Server Ruby on Sinatra**

```
bundle exec cap production deploy # Default branch master
```

## Documents

- Sinatra x Puma x Nginx: https://rooter.jp/rpa/sinatra-puma-nginx-api/
