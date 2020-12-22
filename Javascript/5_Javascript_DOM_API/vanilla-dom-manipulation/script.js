document.addEventListener("DOMContentLoaded", () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelectorAll("#restaurants li").forEach((li) => {
    li.addEventListener("click", toggleLi);
  });



  // adding SF places as list items
  
  const input = document.querySelector('.favorite-input');
  const submit = document.querySelector('.favorite-submit');

  submit.addEventListener("click", (e) => {
    e.preventDefault();
    const newPlace = input.value;
    const newli = document.createElement('li');
    newli.textContent = newPlace;
    document.querySelector('#sf-places').appendChild(newli);
    input.value = "";
  })
  

  // adding new photos
  const photoFormButton = document.querySelector('.photo-show-button');
  const photoContainer = document.querySelector('.photo-form-container');
  
  photoFormButton.addEventListener('click', e => addPhoto(e));

  const addPhoto = (e) => {
    e.preventDefault();
    // Remove hidden form
    photoContainer.classList.remove('hidden');
    const photoForm = photoContainer.firstElementChild;
    photoForm.addEventListener('submit', e => appendPhoto(e));
  }

  const appendPhoto = (e) => {
    e.preventDefault();
    const photoInput = document.querySelector('.photo-url-input');
    const photoUrl = photoInput.value;
    // Clear
    photoInput.value = "";
    const newImgLi = document.createElement('li');
    const newImg = document.createElement('img');
    newImg.src = photoUrl;
    newImgLi.appendChild(newImg);
    document.querySelector('.dog-photos').appendChild(newImgLi);
    photoContainer.classList.add('hidden');
  }

});
