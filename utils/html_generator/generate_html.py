from jinja2 import Template
import json
from pprint import pprint

data = json.load(open("data.json"))

def generate_header():
    
	header = {
		"name": "Subhamay Bhattacharyya",
		"address": "23 Rosebud Dr, Trumbull, CT-06611, USA",
		"email": "subhamay@subhamay.cloud",
		"phone": "+1 203-482-3898"
	}

	return header


template_str = """
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" >
    <meta name="viewport" content="width=device-width, initial-scale=1" >
    <title>Andrew Brown's Cloud Engineer Résumé</title>
    <link rel="stylesheet" href="/assets/stylesheets/style.css">
  </head>
<body location="resume">
    <main>
      <header>
        <nav>
          <a href="/">Home</a>
          <a class="active" href="/resume.html">Résumé </a>
          <a href="/projects.html">Projects</a>
        </nav>
      </header>
      <div class="content_wrap">
        <div class="content">
          <article>
            <section class="header">
            <h1>{{ resume.header.name }}</h1>
            <p>
             {{ resume.header.address }}<br>
             <a href="mailto:{{ resume.header.email }}">{{ resume.header.email }}</a><br>
            {{ resume.header.phone }}<br>
            </p>
            </section>
            <section class="education">
            </section>
            <section class="experience">
            </section>
            <section class="skills">
            </section>
            <section class="certifications">
            </section>
          </article>
        </div><!-- div.content -->
      </div><!-- div.content_wrap -->
    </main>
</body>
</html>
"""

resume = dict(
    header=generate_header(),
		# education=data["education"],
		# experience=data["experience"],
		# skills=data["skills"],
		# certifications=data["certifications"],
)
# pprint(resume)
template = Template(template_str)
html = template.render(resume=resume)
pprint(html)