class Transaction < ApplicationRecord
  belongs_to :transactionable, polymorphic: true

  enum kind: {
    pago_empleado: "pago_empleado",
    compra_animal: "compra_animal",
    venta_animal: "venta_animal",
    compra_cosecha: "compra_cosecha",
    venta_cosecha: "venta_cosecha",
    pago_proveedor: "pago_proveedor"
  }

  enum status: {
    pendiente: "pendiente",
    completado: "completado"
  }
end
