require "json"

class PaymentWorker
  include Sneakers::Worker
  from_queue "payment_update"

  def work(msg)
    puts "::::::::::: PAYMENT RECEIVED ::::::::::"
    policy_data = JSON.parse(msg, symbolize_names: true)

    ActiveRecord::Base.connection_pool.with_connection do
      policy = Policy.find_by(payment_id: policy_data[:payment_id])
      policy.active!

      puts "######### PAYMENT UPDATED #########"
      p policy

      ack!
    end
  rescue => e
    ack!
    Sneakers.logger.error "ERROR: #{e.message}"
  end
end
