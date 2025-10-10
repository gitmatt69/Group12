from flask import Flask, render_template
import sqlite3
import os
DATABASE = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'inventory.db')

app = Flask(__name__)


def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/suppliers')
def suppliers():
    conn = get_db_connection()
    suppliers = conn.execute('SELECT * FROM Suppliers').fetchall()
    conn.close()
    return render_template('suppliers.html', suppliers=suppliers)

@app.route('/inventory')
def inventory():
    return render_template('inventory.html')


@app.route('/orders')
def orders():
    return render_template('orders.html')

@app.route('/reports')
def reports():
    return render_template('reports.html')

@app.route('/performance')
def performance():
    return render_template('performance.html')

@app.route('/settings')
def settings():
    return render_template('settings.html')

if __name__ == '__main__':
    app.run(debug=True)
