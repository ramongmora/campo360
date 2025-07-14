import { application } from "controllers/application"
import ModalController from "./modal_controller"
import AnimalLineController from "./animal_line_controller"

import MapController from "./map_controller"
application.register("map", MapController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

application.register("modal", ModalController)
application.register("animal-line", AnimalLineController)
