# frozen_string_literal: true

class OperatorsController < ApplicationController
  include Pagination

  def index
    render :index, locals: { operators: paginate(AML::Operator.ordered) }
  end

  def new
    render :new, locals: { operator: AML::Operator.new(permitted_params) }
  end

  def create
    attrs = permitted_params
    operator = AML::Operator.create! attrs

    auto_login operator, true if AML::Operator.one?

    redirect_to operators_path
  rescue ActiveRecord::RecordInvalid => e
    flash.now.alert = e.message
    render :new, locals: { operator: e.record }
  end

  def edit
    render :edit, locals: { operator: operator }
  end

  def update
    operator.update!(permitted_params)
    redirect_to operators_path
  rescue ActiveRecord::RecordInvalid => e
    flash.now.alert = e.message
    render :edit, locals: { operator: e.record }
  end

  def block
    operator.block!
    redirect_to users_path, notice: "Оператор, #{operator.email} был заблокирован"
  end

  def unblock
    operator.unblock!
    redirect_to users_path, notice: "Оператор, #{operator.email} был разблокирован"
  end

  private

  def operator
    @operator ||= AML::Operator.find params[:id]
  end

  def permitted_params
    params.fetch(:operator, {}).permit(:email, :name, :role, :password, :password_confirmation, :workflow_state)
  end
end
