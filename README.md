## Chatbot App

<img width="1047" alt="image" src="https://github.com/TOMOSIA-VIETNAM/chatbot-ruby-sample/assets/77431580/3768166b-5be2-4d82-8618-a6d8374880de">

### Technologies:

1. Fontend: HTML, CSS, JS

2. Backend (NodeJS): ExpressJS, Cors, OpenAI API

3. Backend (Ruby Sinatra): Sinatra, Puma, OpenAI API, Ruby 3.2.1

### 2. Start App

#### 2.1 Client

```bash
cd javascripts

npm install # Install libraries

npm run dev # Start with development environment

npm run build # Package into static files

npm run preview # Start server to access static files after building
```

#### 2.2 Server Ruby on Sinatra

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

### 3. Deployment

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

### 4. Training data vector

1. Standardize CSV data including vector data

```bash
bundle exec ruby services/embeddings/csv/normalize.rb
```

2. Perform training and save vectors to the database (pinecone)

```bash
bundle exec ruby services/embeddings/trainings/pinecone.rb
```

3. Run the test

```bash
bundle exec ruby services/embeddings/testing.rb
```

**Use file ```services/embeddings/build_chat.rb``` to pass the prompt and retrieve the response.**

## Documents

- Sinatra x Puma x Nginx: https://rooter.jp/rpa/sinatra-puma-nginx-api/
