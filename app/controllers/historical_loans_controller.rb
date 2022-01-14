# frozen_string_literal: true

class HistoricalLoansController < ApplicationController
  before_action :logged_in_user

  def index
    @loans = current_user.historical_loans.paginate(page: params[:page])
  end
end
