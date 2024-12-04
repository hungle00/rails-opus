import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ["progress", "progressWrapper"];

  export() {
    fetch('/photos/exports')
      .then(() => {
        this.progressWrapperTarget.classList.remove("hidden");
        this.subscribe_channel(this.progressTarget)
      })
      .catch((error) => {
        console.error('Error:', error);
      });
  }

  subscribe_channel(progressTarget) {
    this.channel = createConsumer().subscriptions.create("ExportCsvChannel", {
      connected() {
        console.log("hello")
      },
    
      disconnected() {
        // Called when the subscription has been terminated by the server
      },
    
      received(data) {
        console.log(data["jid"])
        if (data["jid"] == null) {
          progressTarget.style.width = `${data["progress"]}%`;
        } else {
          window.location.href = `/photos/exports/download.csv?id=${data["jid"]}`
        }
      }
    });
  }
}
