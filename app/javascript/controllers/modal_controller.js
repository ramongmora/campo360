export default class extends HTMLElement {
  connect() {
    const modal = new bootstrap.Modal(this)
    modal.show()

    this.addEventListener("hidden.bs.modal", () => {
      this.remove()
    })
  }
}
