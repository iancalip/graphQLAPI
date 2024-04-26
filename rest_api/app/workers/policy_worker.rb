require "json"

class PolicyWorker
  include Sneakers::Worker
  from_queue "policy_created"

  def work(raw_policy)
    p ":::::::::::::: POLICY RECEIVED ::::::::::::::"
    policy_data = JSON.parse(raw_policy)

    policy = Policy.create!(
      issued_date: policy_data["issued_date"],
      end_coverage_date: policy_data["end_coverage_date"],
      status: policy_data["status"],
      payment_id: policy_data["payment_id"],
      payment_link: policy_data["payment_link"]
    )
    puts "Policy created: #{policy.inspect}"

    insured = Insured.find_or_create_by(
      policy: policy,
      name: policy_data["insured"]["name"],
      cpf: policy_data["insured"]["cpf"]
    )
    puts "Insured associated: #{insured.inspect}"

    vehicle = Vehicle.find_or_create_by(
      policy:,
      plate: policy_data["vehicle"]["plate"],
      model: policy_data["vehicle"]["model"],
      brand: policy_data["vehicle"]["brand"],
      year: policy_data["vehicle"]["year"]
    )
    puts "Vehicle associated: #{vehicle.inspect}"

    ack!
  end
end
