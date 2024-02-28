require "json"

class PolicyWorker
  include Sneakers::Worker
  from_queue "policy_created"

  def work(raw_policy)
    p raw_policy
    policy_data = JSON.parse(raw_policy)

    policy = Policy.create!(
      issued_date: policy_data["issued_date"],
      end_coverage_date: policy_data["end_coverage_date"]
    )

    insured = policy_data["insured"]
    insured_data = {policy:, name: insured["name"], cpf: insured["cpf"]}
    Insured.find_or_create_by(insured_data)

    vehicle = policy_data["vehicle"]
    vehicle_data = {policy:,
                    plate: vehicle["plate"], model: vehicle["model"],
                    brand: vehicle["brand"], year: vehicle["year"]}
    Vehicle.find_or_create_by(vehicle_data)

    ack!
  end
end
