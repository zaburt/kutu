module ArticlesHelper

  def rating_keys
    [
      :rating_puzzle,
      :rating_fun,
      :rating_fluency,
      :rating_ambience,
      :rating_management,
      :rating_service
    ]
  end

  def rating_name(attr_key)
    t("activerecord.attributes.article.#{attr_key}")
  end
end
