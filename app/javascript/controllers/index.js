import { application } from "controllers/application"
import ModalController from "./modal_controller"
import AnimalLineController from "./animal_line_controller"

import MapController from "./map_controller"
application.register("map", MapController)

application.register("modal", ModalController)
application.register("animal-line", AnimalLineController)
