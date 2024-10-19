const navigationOptions = [
  {
    name: 'home',
    color: '#CCCCFF'
  },
  {
    name: 'services',
    color: '#9FE2BF'
  },
  {
    name: 'search',
    color: '#808B96'
  },
  {
    name: 'profile',
    color: '#D6DBDF  '
  }
];

const links = document.querySelectorAll('nav a');

function handleClick(e) {
  e.preventDefault();
  const targetId = this.getAttribute('href').substring(1);
  const targetElement = document.getElementById(targetId);
  if (targetElement) {
    targetElement.scrollIntoView({ behavior: 'smooth' });

  }
  links.forEach(link => {
    if (link.classList.contains('active')) {
      link.classList.remove('active');
    }
  });

  const name = this.textContent.trim().toLowerCase();

  const { color } = navigationOptions.find(item => item.name === name);

  const style = window.getComputedStyle(this);
  const hoverColor = style.getPropertyValue('--hover-c');
  if (color !== hoverColor) {
    this.style.setProperty('--hover-bg', `${color}20`);
    this.style.setProperty('--hover-c', color);
  }

  this.classList.add('active');
  document.querySelector('body').style.background = color;
}

links.forEach(link => link.addEventListener('click', handleClick));



var modal = document.getElementById('id01');

window.onclick = function(event) {
  if (event.target == modal) {
    modal.style.display = "none";
  }
}


function scrollToSection() {
    if (window.location.hash === '#service') {
        var servicesSection = document.getElementById('service');
        if (servicesSection) {
            servicesSection.scrollIntoView({ behavior: 'smooth' });
        }
    }
}

window.onload = function() {
    scrollToSection();
};