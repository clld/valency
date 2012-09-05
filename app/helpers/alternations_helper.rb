module AlternationsHelper

  def coded_uncoded(altn)
    return nil if altn.alternation_type.blank?
    altn.alternation_type=="Coded" ? "Yes" : "No"
  end

end
