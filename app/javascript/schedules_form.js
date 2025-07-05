document.addEventListener("turbo:load", function() {
  const typeSelect = document.querySelector('[name="schedule[schedulable_type]"]');
  const animalElementField = document.getElementById('animal-element-field');
  const cropElementField = document.getElementById('crop-element-field');
  const animalActivityField = document.getElementById('animal-activity-field');
  const cropActivityField = document.getElementById('crop-activity-field');

  function setDisplayAndDisable(element, show) {
    if (!element) return;
    element.style.display = show ? '' : 'none';
    Array.from(element.querySelectorAll('select')).forEach(sel => sel.disabled = !show);
  }

  function toggleFields() {
    if (!typeSelect) return;
    const type = typeSelect.value;

    setDisplayAndDisable(animalElementField, type === 'Animal');
    setDisplayAndDisable(animalActivityField, type === 'Animal');
    setDisplayAndDisable(cropElementField, type === 'Crop');
    setDisplayAndDisable(cropActivityField, type === 'Crop');
  }

  if (typeSelect) {
    typeSelect.addEventListener('change', toggleFields);
    toggleFields();
  }
});
