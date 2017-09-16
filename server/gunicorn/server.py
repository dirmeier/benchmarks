#!/usr/bin/env python3

import sqlite3
from flask import Flask
from flask import render_template
from flask import jsonify
from werkzeug.contrib.fixers import ProxyFix

app = Flask(__name__)
app.wsgi_app = ProxyFix(app.wsgi_app)

@app.route('/')
def start():
	return "Hello World."

@app.route('/db')
def db(name=None):
	conn = sqlite3.connect('/Users/simondi/PHD/data/data/target_infect_x/database/tix_index.db')
	c = conn.cursor()
	c.execute("SELECT * FROM meta")
	res = c.fetchall()
	c.close()
	return jsonify(data=res)

if __name__ == "__main__":
	app.run()