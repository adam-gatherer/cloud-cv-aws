// JavaScript Code to Use Lambda Function

const counter = document.querySelector(".counter-number"); //select the element from index.html
async function updateCounter() { //function that does a fetch request
	let response = await fetch ("https://bujk7hizyolll7qscxgtjcodpy0qzhzx.lambda-url.eu-west-1.on.aws/");
	let data = await response.json(); //stores response as variable called "data"
	counter.innerHTML = `Views: ${data}`; //updates counter in HTML file to use data variable
}

updateCounter();