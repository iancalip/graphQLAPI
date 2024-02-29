require "json"

class PolicyWorker
  include Sneakers::Worker
  from_queue "policy_created"

  def work(raw_policy)
    policy_data = JSON.parse(raw_policy)
    policy = Policy.create!(
      issued_date: policy_data["issued_date"],
      end_coverage_date: policy_data["end_coverage_date"]
    )
    puts "Policy created: #{policy.id}"

    Insured.find_or_create_by(
      policy:,
      name: policy_data["insured"]["name"],
      cpf: policy_data["insured"]["cpf"]
    )
    puts "Insured associated: #{Insured.last.id}"

    Vehicle.find_or_create_by(
      policy:,
      plate: policy_data["vehicle"]["plate"],
      model: policy_data["vehicle"]["model"],
      brand: policy_data["vehicle"]["brand"],
      year: policy_data["vehicle"]["year"]
    )
    puts "Vehicle associated: #{Vehicle.last.id}"

    ack!
  end
end
