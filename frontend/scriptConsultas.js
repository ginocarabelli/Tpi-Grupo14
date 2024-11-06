const myModal = document.getElementById('myModal')
const myInput = document.getElementById('myInput')

myModal.addEventListener('shown.bs.modal', () => {
  myInput.focus()
})


const fetchConsulta1 = async function(puntuacion) {
  const response = await fetch(`https://localhost:44347/1/${puntuacion}`);

  if(!response.ok){
    throw new Error(error);
  }
  
  const data = await response.json();
  const tbody = document.getElementById('consulta1');
  tbody.innerHTML = '';

  data.forEach(genero => {
    const col = document.createElement('th');
    col.textContent = data[0];
    const row = document.createElement('tr');
    row.innerHTML = `<td>${genero.genero}</td><td>${genero.puntuacionPromedio}</td>`;
    tbody.appendChild(row);
  });
}

const fetchConsulta2 = async function() {
  const response = await fetch(`https://localhost:44347/2`);

  if(!response.ok){
    console.log('error');
  }
  
  const data = await response.json();

  const tbody = document.getElementById('consulta2');
  tbody.innerHTML = '';

  data.forEach(cliente => {
    const row = document.createElement('tr');
    row.innerHTML = `<td>${cliente.nombre}</td><td>${cliente.apellido}</td><td>${cliente.reservas}</td>`;
    tbody.appendChild(row);
  });
}

const fetchConsulta3 = async function() {
  const response = await fetch(`https://localhost:44347/3`);

  if(!response.ok){
    console.log('error');
  }
  
  const data = await response.json();

  const tbody = document.getElementById('consulta3');
  tbody.innerHTML = '';

  data.forEach(element3 => {
    const row = document.createElement('tr');
    row.innerHTML = `<td>${element3.sucursal}</td><td>${element3.ingreso}</td>`;
    tbody.appendChild(row);
  });
}

const fetchConsulta4 = async function() {
  const response = await fetch(`https://localhost:44347/4`);

  if(!response.ok){
    console.log('error');
  }
  
  const data = await response.json();

  const tbody = document.getElementById('consulta4');
  tbody.innerHTML = '';

  data.forEach(element4 => {
    let dateFormatted = element4.fecha.slice(0,-9);
    let hourFormatted = element4.horario.slice(0, -3);
    const row = document.createElement('tr');
    row.innerHTML = `<td>${element4.pelicula}</td>
    <td>${element4.sucursal}</td>
    <td>${dateFormatted}</td>
    <td>${hourFormatted}</td>
    <td>${element4.asientosDisponibles}</td>`;
    tbody.appendChild(row);
  });
}

const fetchConsulta5 = async function() {
  const response = await fetch(`https://localhost:44347/5`);

  if(!response.ok){
    console.log('error');
  }
  
  const data = await response.json();

  const tbody = document.getElementById('consulta5');
  tbody.innerHTML = '';

  data.forEach(element => {
    const row = document.createElement('tr');
    row.innerHTML = `<td>${element.titulo}</td><td>${element.puntuacion}</td><td>${element.genero}</td>`;
    tbody.appendChild(row);
  });
}

const fetchConsulta6 = async function() {
  const response = await fetch(`https://localhost:44347/6`);

  if(!response.ok){
    console.log('error');
  }
  
  const data = await response.json();

  const tbody = document.getElementById('consulta6');
  tbody.innerHTML = '';

  data.forEach(element => {
    const row = document.createElement('tr');
    row.innerHTML = `<td>${element.cliente}</td><td>${element.asiento}</td><td>${element.descuento}</td><td>${element.reservas}</td>`;
    tbody.appendChild(row);
  });
}

const fetchConsulta7 = async function() {
  const response = await fetch(`https://localhost:44347/7`);

  if(!response.ok){
    console.log('error');
  }
  
  const data = await response.json();

  const tbody = document.getElementById('consulta7');
  tbody.innerHTML = '';

  data.forEach(element => {
    const row = document.createElement('tr');
    row.innerHTML = `<td>${element.pelicula}</td><td>${element.totalIngresos}</td>`;
    tbody.appendChild(row);
  });
}

const fetchConsulta8 = async function() {
  const response = await fetch(`https://localhost:44347/8`);

  if(!response.ok){
    console.log('error');
  }
  
  const data = await response.json();

  const tbody = document.getElementById('consulta8');
  tbody.innerHTML = '';

  data.forEach(element => {
    const row = document.createElement('tr');
    row.innerHTML = `<td>${element.director}</td><td>${element.cantidadPeliculas}</td><td>${element.puntuacion}</td>`;
    tbody.appendChild(row);
  });
}


const formConsulta1 = document.getElementById('formConsulta1');
formConsulta1.addEventListener("submit", async (e) => {
  e.preventDefault();
  const puntuacion = document.getElementById('puntuacion').value;
  await fetchConsulta1(puntuacion);
});


const acordeones = [
  { id: 'accordion2', fetchFunction: fetchConsulta2 },
  { id: 'accordion3', fetchFunction: fetchConsulta3 },
  { id: 'accordion4', fetchFunction: fetchConsulta4 },
  { id: 'accordion5', fetchFunction: fetchConsulta5 },
  { id: 'accordion6', fetchFunction: fetchConsulta6 },
  { id: 'accordion7', fetchFunction: fetchConsulta7 },
  { id: 'accordion8', fetchFunction: fetchConsulta8 }
];

// Iterar sobre el array para agregar el event listener a cada acordeón
acordeones.forEach(acordeon => {
  const accordionButton = document.querySelector(`#${acordeon.id} .accordion-button`);
  if (accordionButton) {
    accordionButton.addEventListener('click', () => {
      if (!accordionButton.classList.contains('collapsed')) {
        acordeon.fetchFunction(); // Llamar a la función correspondiente
      }
    });
  }
});