import React from 'react';
import ReactDOM from 'react-dom';

import Root from './frontend/root';

document.addEventListener("DOMContentLoaded", () => {
  const root = document.getElementById("main");
  ReactDOM.render(<Root />, root);
});
