module Graphql::Queries
  def self.get_policies
    {
      query: 'query { policies {
        id status issuedDate endCoverageDate paymentId paymentLink
        insured { name cpf }
        vehicle { plate brand model year }
        }
      }'
    }
  end
end
