// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import ModalController from "./modal_controller"
application.register("modal", ModalController)
