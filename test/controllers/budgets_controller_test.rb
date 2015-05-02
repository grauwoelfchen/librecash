require "test_helper"

class BudgetsControllerTest < ActionController::TestCase
  locker_room_fixtures(:accounts, :members, :users)
  fixtures(:accounts, :budgets)

  def test_get_show
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      get(:show, :account_id => budget.account_id)
      assert_equal(budget, assigns[:budget])
      assert_equal(budget.account, assigns[:account])
      assert_template(:show)
      assert_response(:success)
    end
  end

  def test_get_edit
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      get(:edit, :account_id => budget.account_id)
      assert_equal(budget, assigns[:budget])
      assert_equal(budget.account, assigns[:account])
      assert_template(:edit)
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_put_update_with_validation_errors
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      params = {
        :account_id => budget.account_id,
        :budget     => {
          :title => ""
        }
      }
      put(:update, params)
      assert_equal(budget, assigns[:budget])
      assert_equal(budget.account, assigns[:account])
      assert_nil(flash[:notice])
      assert_equal(
        "Budget could not be updated.",
        ActionController::Base.helpers.strip_tags(flash[:alert])
      )
      assert_template(:edit)
      assert_template(:partial => "shared/_error")
      assert_template(:partial => "_form")
      assert_response(:success)
    end
  end

  def test_put_update
    user = user_with_schema(:oswald)
    within_subdomain(user.account.subdomain) do
      login_user(user)
      budget = budgets(:second_piano_budget)
      params = {
        :account_id => budget.account_id,
        :budget     => {
          :title => "Violin budget"
        }
      }
      put(:update, params)
      assert_equal(params[:budget][:title], assigns[:budget].title)
      assert_equal(budget.account, assigns[:account])
      assert_equal(
        "Budget has been successfully updated.",
        ActionController::Base.helpers.strip_tags(flash[:notice])
      )
      assert_nil(flash[:alert])
      assert_response(:redirect)
      assert_redirected_to(account_budget_url(assigns[:account]))
    end
  end
end
