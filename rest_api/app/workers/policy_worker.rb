require "json"

class PolicyWorker
  include Sneakers::Worker
  from_queue "policy_created"

  def work(raw_policy)
    p ":::::::::::::: POLICY RECEIVED ::::::::::::::"
    policy_data = JSON.parse(raw_policy, symbolize_names: true)

    ActiveRecord::Base.connection_pool.with_connection do
      policy = Policy.create!(
        issued_date: policy_data[:issued_date],
        end_coverage_date: policy_data[:end_coverage_date],
        status: policy_data[:status],
        payment_id: policy_data[:payment_id],
        payment_link: policy_data[:payment_link]
      )
      puts "Policy created: #{policy.inspect}"

      insured = Insured.find_or_create_by(cpf: policy_data[:insured][:cpf]) do |i|
        i.name = policy_data[:insured][:name]
        i.policy = policy
      end

      puts "Insured associated: #{insured.inspect}"

      vehicle = Vehicle.find_or_create_by(plate: policy_data[:vehicle][:plate]) do |v|
        v.brand = policy_data[:vehicle][:brand]
        v.model = policy_data[:vehicle][:model]
        v.year = policy_data[:vehicle][:year]
        v.policy = policy
      end

      puts "Vehicle associated: #{vehicle.inspect}"
      ack!
    end
  rescue => e
    ack!
    Sneakers.logger.error "ERROR: #{e.message}"
  end
end
