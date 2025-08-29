import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="form-prevent-default"
export default class extends Controller {
  static targets = ["tomSelect"];

  reset() {
    console.log("reset");
    console.log(this.element);
    this.element.reset();
    if (this.tomSelect) {
      this.tomSelect.clear();
    }
  }

  connect() {
    if (this.hasTomSelectTarget) {
      this.tomSelect = new TomSelect(this.tomSelectTarget, {
        theme: "bootstrap5",
        create: false,
        allowEmptyOption: true,
        placeholder: "Search exercises...",
        dropdownParent: "body",
        sortField: {
          field: "text",
          direction: "asc",
        },
      });

      this.exercisePhotos = JSON.parse(
        this.tomSelectTarget.closest("[data-exercise-photos]").dataset
          .exercisePhotos
      );

      this.tomSelectTarget.addEventListener(
        "change",
        this.updatePreview.bind(this)
      );
    }
  }

  updatePreview(event) {
    const exerciseId = event.target.value;
    const photoUrl = this.exercisePhotos[exerciseId];
    const preview = document.getElementById("exercise-preview");
    if (photoUrl) {
      // Cloudinary direct URL pattern: https://res.cloudinary.com/<cloud_name>/image/upload/<photoKey>
      preview.src = photoUrl;
      preview.style.display = "inline-block";
    } else {
      preview.src = "";
      preview.style.display = "none";
    }
  }
}
