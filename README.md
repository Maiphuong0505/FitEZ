# 📚 FitEZ
<p>FitEZ is a client management tool built for personal trainers. It streamlines admin tasks like scheduling, workout planning, and progress tracking, so trainers can focus on what matters most—their clients. With features like visualized body metrics, easy workout logging, and AI-powered exercise suggestions, FitEZ makes training smarter and managing your business easier.</p> 
<p>App home: https://www.fitez.fit/</p>
<p align="center">
  <img src="https://res.cloudinary.com/dfeqtndfr/image/upload/v1759143867/IMG_2867_lgw5zj.jpg" width="150" alt="App Screenshot 1" />&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://res.cloudinary.com/dfeqtndfr/image/upload/v1759143972/IMG_2869_fy9j5p.jpg" width="150" alt="App Screenshot 2" />&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://res.cloudinary.com/dfeqtndfr/image/upload/v1759143533/IMG_2863_almbj1.jpg" width="150" alt="App Screenshot 3" />&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://res.cloudinary.com/dfeqtndfr/image/upload/v1759143549/IMG_2865_zrnd5k.jpg" width="150" alt="App Screenshot 4" />&nbsp;&nbsp;&nbsp;&nbsp;
  <img src="https://res.cloudinary.com/dfeqtndfr/image/upload/v1759144217/IMG_2866_o71wfe.jpg" width="150" alt="App Screenshot 5" />
</p>

## Getting Started

### Setup

Install gems

```bash
bundle install
```

### ENV Variables

Create `.env` file

```bash
touch .env
```

Inside `.env`, set these variables.

```ruby
CLOUDINARY_URL=your_own_cloudinary_url_key
OPENAI_ACCESS_TOKEN=your_own_openai_token
```

### DB Setup

```bash
rails db:create
rails db:migrate
rails db:seed
```

### Run a server

```bash
rails s
```

## Built with
- [Rails 7](https://guides.rubyonrails.org/) - Backend / Front-end
- [Stimulus JS](https://stimulus.hotwired.dev/) - Front-end JS
- [Heroku](https://www.heroku.com/) - Deployment
- [PostgreSQL](https://www.postgresql.org/) - Database
- [Bootstrap](https://getbootstrap.com/) — Styling
- [Figma](https://www.figma.com/) — Prototyping

## Team Members
- [Mai Phuong](https://github.com/Maiphuong0505)
- [Bruno Vetorazo](https://github.com/vetorazo)
- [Hannah Lapasaran](https://github.com/hnnhtky)
- [Takatomo Homma](https://github.com/TKHM48)
