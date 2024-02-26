require "sneakers"
require "json"

class PolicyWorker
  include Sneakers::Worker
  from_queue "policy_created"

  def work(raw_policy)
    policy_data = JSON.parse(raw_policy)

    segurado = Insured.find_or_create_by(cpf: policy_data["segurado"]["cpf"]) do |s|
      s.name = policy_data["segurado"]["nome"]
    end

    veiculo = Vehicle.find_or_create_by(plate: policy_data["veiculo"]["placa"]) do |v|
      v.brand = policy_data["veiculo"]["marca"]
      v.model = policy_data["veiculo"]["modelo"]
      v.year = policy_data["veiculo"]["ano"]
    end

    policy = Policy.create!(
      issued_date: policy_data["data_emissao"],
      end_coverage_date: policy_data["data_fim_emisssao"],
      insured: segurado,
      vehicle: veiculo
    )

    ack!
  end
end
