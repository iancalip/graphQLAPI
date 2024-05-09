module Graphql::Mutations
  def self.create_policy(params, payment_id, payment_url)
    {
      query: "mutation createPolicy(
        $issuedDate: ISO8601Date!
        $endCoverageDate: ISO8601Date!
        $status: String!
        $paymentId: String!
        $paymentLink: String!
        $insuredName: String!
        $insuredCpf: String!
        $vehiclePlate: String!
        $vehicleBrand: String!
        $vehicleModel: String!
        $vehicleYear: String!
      )
      {
        createPolicy (
          input: {
            policy:{
              issuedDate: $issuedDate
              endCoverageDate: $endCoverageDate
              status: $status
              paymentId: $paymentId
              paymentLink: $paymentLink
              insured: {
                name: $insuredName,
                cpf: $insuredCpf
              }
              vehicle: {
                plate: $vehiclePlate
                brand: $vehicleBrand
                model: $vehicleModel
                year: $vehicleYear
              }
            }
          }
        ) { result }
      }",
      variables: {
        issuedDate: Date.parse(params[:issued_date]).iso8601,
        endCoverageDate: Date.parse(params[:end_coverage_date]).iso8601,
        status: "pending",
        paymentId: payment_id,
        paymentLink: payment_url,
        insuredName: params[:insured_name],
        insuredCpf: params[:insured_cpf],
        vehiclePlate: params[:vehicle_plate],
        vehicleBrand: params[:vehicle_brand],
        vehicleModel: params[:vehicle_model],
        vehicleYear: params[:vehicle_year]
      }
    }
  end
end
