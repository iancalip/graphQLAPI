module Graphql::Mutations
  def self.create_policy(params, payment_id, payment_url)
    {
      query: "mutation createPolicy(
        $issuedDate: ISO8601Date!
        $endCoverageDate: ISO8601Date!
        $insuredName: String!
        $insuredCpf: String!
        $vehiclePlate: String!
        $vehicleBrand: String!
        $vehicleModel: String!
        $vehicleYear: String!
        $status: Int!
        $paymentId: String!
        $paymentLink: String!
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
        ) { success }
      }",
      variables: {
        issuedDate: Date.parse(params[:issued_date]).iso8601,
        endCoverageDate: Date.parse(params[:end_coverage_date]).iso8601,
        status: 0,
        insuredName: params[:insured_name],
        insuredCpf: params[:insured_cpf],
        vehiclePlate: params[:vehicle_plate],
        vehicleBrand: params[:vehicle_brand],
        vehicleModel: params[:vehicle_model],
        vehicleYear: params[:vehicle_year],
        paymentId: payment_id,
        paymentLink: payment_url
      }
    }
  end
end
