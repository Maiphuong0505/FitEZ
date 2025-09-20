import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="ai-session"
export default class extends Controller {
  static targets = ["tomSelect"];

  connect() {
    console.log("Ai form controller connected");
    this.initializeTomSelect();
  }

  initializeTomSelect() {
    console.log("Initializing AI tom-select");
    console.log("tomSelectTarget", this.tomSelectTarget);
    if (this.hasTomSelectTarget) {
      console.log("Tom select found", this.tomSelectTarget);
      if (this.tomSelect) {
        this.tomSelect.destroy();
      }
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

      const selectedValue = this.tomSelectTarget.value;
      if (selectedValue) {
        this.updatePreviewForValue(selectedValue);
      }
    }
  }

  updatePreview(event) {
    const exerciseId = event.target.value;
    this.updatePreviewForValue(exerciseId);
  }

  updatePreviewForValue(exerciseId) {
    const photoUrl = this.exercisePhotos[exerciseId];
    const preview = document.getElementById("photo-preview");
    if (photoUrl && preview) {
      // Cloudinary direct URL pattern: https://res.cloudinary.com/<cloud_name>/image/upload/<photoKey>
      preview.src = photoUrl;
      preview.style.display = "inline-block";
    } else {
      preview.src = "";
      preview.style.display = "none";
    }
  }
}
