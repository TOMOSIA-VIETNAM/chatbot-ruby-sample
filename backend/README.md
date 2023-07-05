## Run Server

### Development

```
bundle exec rackup config.ru -p 4567
```

### Production
```
bundle exec puma -e production -C config/puma.rb
```

## Documents

- Sinatra x Puma x Nginx: https://rooter.jp/rpa/sinatra-puma-nginx-api/
