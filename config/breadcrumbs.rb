# finance

crumb :'finance/ledgers' do
  link Finance::Ledger.model_name.human.pluralize, finance_ledgers_path
end

crumb :'finance/ledger' do |ledger|
  unless ledger.persisted?
    link t('crumb.new'), nil
  else
    link ledger.name, [:overview, :finance, ledger]
  end
  parent :'finance/ledgers'
end

crumb :'finance/categories' do |ledger|
  link Finance::Category.model_name.human.pluralize, finance_ledger_categories_path(ledger)
  parent :'finance/ledger', ledger
end

crumb :'finance/category' do |ledger, category|
  unless category.persisted?
    link t('crumb.new'), nil
  else
    link category.name, finance_ledger_category_path(ledger, category)
  end
  parent :'finance/categories', ledger
end

crumb :'finance/accounts' do |ledger|
  link Finance::Account.model_name.human.pluralize, finance_ledger_accounts_path(ledger)
  parent :'finance/ledger', ledger
end

crumb :'finance/account' do |ledger, account|
  unless account.persisted?
    link t('crumb.new'), nil
  else
    link account.name, finance_ledger_account_path(ledger, account)
  end
  parent :'finance/accounts', ledger
end

crumb :'finance/transactions' do |ledger, account, category|
  link Finance::Transaction.model_name.human.pluralize, finance_ledger_account_transactions_path(ledger, account)
  if category
    link category.name, finance_ledger_category_path(ledger, category)
  end
  parent :'finance/account', ledger, account
end

crumb :'finance/transaction' do |ledger, account, transaction|
  unless transaction.persisted?
    link t('crumb.new'), nil
  else
    link transaction.title, finance_ledger_account_transaction_path(ledger, account, transaction)
  end
  parent :'finance/transactions', ledger, account
end

crumb :'finance/budget' do |ledger|
  link Finance::Budget.model_name.human, finance_ledger_budget_path(ledger)
  parent :'finance/ledger', ledger
end

# snippets

crumb :snippets do
  link Snippet.model_name.human.pluralize, snippets_path
end

crumb :snippets_with_tag  do |tag|
  link t('crumb.tag', tag: truncate(tag, length: 8)), nil
  parent :snippets
end

crumb :snippet do |snippet|
  unless snippet.persisted?
    link t('crumb.new'), nil
  else
    link truncate(snippet.title, length: 27), snippet
  end
  parent :snippets
end

# contacts

crumb :contacts do
  link Contact.model_name.human.pluralize, contacts_path
end

crumb :contacts_with_tag  do |tag|
  link t('crumb.tag', tag: truncate(tag, length: 8)), nil
  parent :contacts
end

crumb :contact do |contact|
  unless contact.persisted?
    link t('crumb.new'), nil
  else
    link contact.name, contact_path(contact)
  end
  parent :contacts
end

# settings

crumb :'settings/user' do
  link t('nav.settings'), locker_room.edit_user_path
end

crumb :'settings/team' do
  link t('nav.settings'), locker_room.edit_team_path
end

crumb :'settings/mate' do
  link t('nav.settings'), locker_room.mates_path
end
