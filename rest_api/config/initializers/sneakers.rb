require "sneakers"
Sneakers.configure amqp: "amqp://guest:guest@rabbitmq:5672",
  daemonize: false,
  log: `$stdout`
Sneakers.logger.level = Logger::INFO
