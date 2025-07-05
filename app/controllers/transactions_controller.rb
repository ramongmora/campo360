class TransactionsController < ApplicationController
  before_action :set_location, only: %i[index new create]
  before_action :set_transaction, only: %i[edit update destroy]
  before_action :load_transactionables, only: %i[new create edit update]

  def index
    @transactions = Transaction.where(
      transactionable_type: "Employee", transactionable_id: @location.employees.pluck(:id)
    ).or(
      Transaction.where(transactionable_type: "Animal", transactionable_id: @location.animals.pluck(:id))
    ).or(
      Transaction.where(transactionable_type: "Crop", transactionable_id: @location.crops.pluck(:id))
    ).or(
      Transaction.where(transactionable_type: "Supplier", transactionable_id: Supplier.pluck(:id))
    )
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)

    begin
      model_class = params[:transaction][:transactionable_type].constantize
      target = model_class.find(params[:transaction][:transactionable_id])
      @transaction.transactionable = target
    rescue StandardError => e
      flash.now[:alert] = "Error al asociar el modelo: #{e.message}"
      render :new, status: :unprocessable_entity and return
    end

    if @transaction.save
      redirect_to admin_path, notice: "Transacción creada correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @location = @transaction.transactionable.try(:location) || Location.first
  end

  def update
    if params[:transaction][:status] == "completado"
      @transaction.update(status: "completado")
      redirect_to admin_path, notice: "Transacción marcada como completada."
    elsif @transaction.update(transaction_params)
      redirect_to admin_path, notice: "Transacción actualizada correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @transaction.destroy
    redirect_to admin_path, notice: "Transacción eliminada correctamente."
  end

  private

  def set_location
    @location = Location.find(params[:location_id]) if params[:location_id]
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(
      :amount, :kind, :status, :date, :notes, :transactionable_type, :transactionable_id
    )
  end

  def load_transactionables
    @employees = @location&.employees || Employee.all
    @animals   = @location&.animals || Animal.all
    @crops     = @location&.crops || Crop.all
    @suppliers = Supplier.all
  end
end
