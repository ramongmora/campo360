import { application } from "controllers/application"
import ModalController from "./modal_controller"
import AnimalLineController from "./animal_line_controller"

application.register("modal", ModalController)
application.register("animal-line", AnimalLineController)
