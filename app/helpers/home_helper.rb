module HomeHelper
  def checkProviderExist(prov)
    User.where(provider: prov).exists?(conditions = :none)
  end
end
