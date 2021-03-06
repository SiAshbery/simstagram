# Simstagram by Simon Ashbery
## What is it?

A profound exploration of human social dynamics cunningly disguised as a website for posting pictures of your food.

## How Does it Work?

- [Visit Simstagram on Heroku](http://sim-stagram.herokuapp.com/)

or

- Clone this repository
- Navigate to the newly cloned directory via your command line
- ```bundle install```
- Make sure it's all working by running ```rspec```
- ```rails server```
- Visit [localhost:3000](http://localhost:3000)
- Make all your friends jealous of your life-style by pretending that photo you just posted was a candid shot of you enjoying life and not your twentieth attempt to hide the void inside behind vintage filters and flattering angles.


## Aims For This Project:

- Better understand the process of working with a framework such as Rails
- Adhere to SOLID design principles
- Test early, Test often, Test thoroughly
- Present the product with a beautiful frontend


## My Approach

My understanding of working with a web application framework is that it incentivises one to perform tasks using a tightly defined and formalised methodology.

Therefore I have opted to carefully model and diagram Simstagram in order to have a clear idea of each step required to build it's features and then to research how best to achieve those steps in Rails.

Since the structure of my program is likely to change during development I will keep my digrams up to date in order to chart it's evolution and the progression of my thinking.

I found it important to get the core functionality of Simstagram working before exploring it's presentation so front end functionality has been left till last.

## Domain Model

![Domain Model](https://github.com/SiAshbery/simstagram/blob/master/Images/Simstagram_Data_Model.png)

## Known Issues/TODOs

- Tests for Session Controller are all currently pending untill I can research how best to approach them
- If rspec tests are failing citing "TypeError: wrong argument type Integer (expected Proc)" This is a bug with Ruby MRI 2.4.0 https://bugs.ruby-lang.org/issues/13107. Please ensure you are using Ruby 2.4.1


## Acknowledgement
- Thanks to [Jenny Wem](https://github.com/wemmm) for showing me how to write a good README

## Other Matters

- Vaporwave is dead, long live Vaporwave
