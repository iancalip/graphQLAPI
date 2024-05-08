require "json"

class PaymentWorker
  include Sneakers::Worker
  from_queue "update_payment"

  def work(msg)
    p ":::::::::::::: PAYMENT RECEIVED ::::::::::::::"
    policy_data = JSON.parse(msg, symbolize_names: true)

    ActiveRecord::Base.connection_pool.with_connection do
      policy = Policy.find_by(payment_id: policy_data[:payment_id])
      policy.update!(status: 1)

      p ":::::::::::::: PAYMENT UPDATED ::::::::::::::"
      p policy
      ack!
    end
  rescue => e
    ack!
    Sneakers.logger.error "ERROR: #{e.message}"
  end
end
