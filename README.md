## Chatbot App

### Technologies:

1. Fontend: HTML, CSS, JS

2. Backend (NodeJS): ExpressJS, Cors, OpenAI API

3. Backend (Ruby Sinatra): Sinatra, Puma, OpenAI API, Ruby 3.2.1

### Start App

#### Client

```bash
cd javascripts

npm install # Install libraries

npm run dev # Start with development environment

npm run build # Package into static files

npm run preview # Start server to access static files after building
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
