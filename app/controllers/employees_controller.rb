class EmployeesController < ApplicationController
  before_action :set_location
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    @employees = @location.employees
  end

  def show
  end

  def new
    @location = Location.find(params[:location_id])
    @employee = Employee.new
  end

  def create
    @location = Location.find(params[:location_id])
    @employee = @location.employees.build(employee_params)

    if @employee.save
      redirect_to location_employees_path(@location), notice: 'Empleado creado exitosamente.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      redirect_to location_employee_path(@location, @employee), notice: "Empleado actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    redirect_to location_employees_path(@location), notice: "Empleado eliminado."
  end

  private

  def set_location
    @location = Location.find(params[:location_id])
  end

  def set_employee
    @employee = @location.employees.find(params[:id])
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :citizen_register, :salary, :email, :password, :password_confirmation)
  end
end
