module FiscalPolicyExtension
  # Return model_name with namespace
  #
  # Finance module's `use_relative_model_naming?` is still false.
  # This omits only model's namespace in route_key.
  # `url_for([:finance, ledger, category])` works as finance_ledger_category_path(ledger, category).
  #
  # see also:
  # https://github.com/rails/rails/blob/0edb6465971f7d937fce2bf0a8e1e2b540d56e0a/activemodel/lib/active_model/naming.rb#L146
  # http://api.rubyonrails.org/classes/ActiveModel/Naming.html#method-i-model_name
  def model_name
    @_model_name ||= begin
      # pass namespage
      namespace = OpenStruct.new
      namespace.name = 'Finance'
      ActiveModel::Name.new(self, namespace)
    end
    super
  end
end
