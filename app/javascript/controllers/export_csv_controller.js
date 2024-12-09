import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  export(e) {
    console.log(e.target)
  }
}
