from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/inventory')
def inventory():
    return render_template('inventory.html')

@app.route('/suppliers')
def suppliers():
    return render_template('suppliers.html')

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
