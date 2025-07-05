class AdminController < ApplicationController
  def index
    @locations = current_user.locations
    location_ids = @locations.pluck(:id)

    # Obtenemos los IDs de modelos asociados a esas locations
    employee_ids = Employee.where(location_id: location_ids).pluck(:id)
    animal_ids   = Animal.where(location_id: location_ids).pluck(:id)
    crop_ids     = Crop.where(location_id: location_ids).pluck(:id)

    # Buscamos las transacciones asociadas a esos IDs por tipo
    employee_tx = Transaction.where(transactionable_type: "Employee", transactionable_id: employee_ids)
    animal_tx   = Transaction.where(transactionable_type: "Animal", transactionable_id: animal_ids)
    crop_tx     = Transaction.where(transactionable_type: "Crop", transactionable_id: crop_ids)

    # Opcional: transacciones globales (proveedores)
    supplier_tx = Transaction.where(transactionable_type: "Supplier")

    # Unimos todas
    @transactions = (employee_tx + animal_tx + crop_tx + supplier_tx).sort_by(&:date).reverse
  end
end
