class LedgerEntriesController < WorkspaceController
  before_action :load_finance
  before_action :load_ledger
  before_action :load_categories, :only => [:new, :create, :edit, :update]
  before_action :load_entry, :only => [:show, :edit, :update, :destroy]

  def new
    @entry = @ledger.entries.new
  end

  def create
    @entry = @ledger.entries.build(ledger_entry_params)
    @category = fetch_category
    if @entry.journalize_to(@category)
      redirect_to finance_ledger_entry_url(@finance, @entry),
        :notice => "Entry has been successfully created."
    else
      flash.now[:alert] = "Entry could not be created."
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @entry.update_attributes(ledger_entry_params)
      redirect_to finance_ledger_entry_url(@finance, @entry),
        :notice => "Entry has been successfully updated."
    else
      flash.now[:alert] = "Entry could not be updated."
      render :edit
    end
  end

  def destroy
  end

  private

  def load_finance
    @finance = Finance.find(params[:finance_id])
  end

  def load_categories
    @categories = @finance.categories
  end

  def load_ledger
    @ledger = @finance.ledger or
      raise ActiveRecord::RecordNotFound
  end

  def load_entry
    @entry = @ledger.entries.find(params[:id])
  end

  def fetch_category
    @finance.categories.find(params[:category_id])
  end

  def ledger_entry_params
    params.require(:ledger_entry).permit(:title, :memo)
  end
end