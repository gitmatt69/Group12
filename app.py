from flask import Flask, render_template, request, redirect, url_for, flash
import sqlite3
import os
DATABASE = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'inventory.db')

app = Flask(__name__)
app.secret_key = 'Campuskeysouth01!'


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
    conn = get_db_connection()
    items = conn.execute('''
        SELECT Items.item_id, Items.item_name, Items.description,
               Categories.category_name, Suppliers.supplier_name,
               Items.unit_price, Items.reorder_level,
               IFNULL(SUM(Stock.quantity), 0) AS total_stock
        FROM Items
        LEFT JOIN Categories ON Items.category_id = Categories.category_id
        LEFT JOIN Suppliers ON Items.supplier_id = Suppliers.supplier_id
        LEFT JOIN Stock ON Items.item_id = Stock.item_id
        GROUP BY Items.item_id
        ORDER BY Items.item_id
    ''').fetchall()
    conn.close()
    return render_template('inventory.html', items=items)



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

@app.route('/inventory/add', methods=['GET', 'POST'])
def add_item():
    conn = get_db_connection()
    if request.method == 'POST':
        name = request.form['name']
        description = request.form['description']
        category_id = request.form['category_id']
        supplier_id = request.form['supplier_id']
        unit_price = request.form['unit_price']
        reorder_level = request.form['reorder_level']

        conn.execute('''
            INSERT INTO Items (item_name, description, category_id, supplier_id, unit_price, reorder_level)
            VALUES (?, ?, ?, ?, ?, ?)
        ''', (name, description, category_id, supplier_id, unit_price, reorder_level))
        conn.commit()
        conn.close()
        flash('Item added successfully!', 'success')
        return redirect(url_for('inventory'))

    categories = conn.execute('SELECT * FROM Categories').fetchall()
    suppliers = conn.execute('SELECT * FROM Suppliers').fetchall()
    conn.close()
    return render_template('add_inventory.html', categories=categories, suppliers=suppliers)

@app.route('/inventory/edit/<int:item_id>', methods=['GET', 'POST'])
def edit_item(item_id):
    conn = get_db_connection()
    item = conn.execute('SELECT * FROM Items WHERE item_id = ?', (item_id,)).fetchone()

    if request.method == 'POST':
        name = request.form['name']
        description = request.form['description']
        category_id = request.form['category_id']
        supplier_id = request.form['supplier_id']
        unit_price = request.form['unit_price']
        reorder_level = request.form['reorder_level']

        conn.execute('''
            UPDATE Items
            SET item_name=?, description=?, category_id=?, supplier_id=?, unit_price=?, reorder_level=?
            WHERE item_id=?
        ''', (name, description, category_id, supplier_id, unit_price, reorder_level, item_id))
        conn.commit()
        conn.close()
        flash('Item updated successfully!', 'success')
        return redirect(url_for('inventory'))

    categories = conn.execute('SELECT * FROM Categories').fetchall()
    suppliers = conn.execute('SELECT * FROM Suppliers').fetchall()
    conn.close()
    return render_template('edit_inventory.html', item=item, categories=categories, suppliers=suppliers)

@app.route('/inventory/delete/<int:item_id>')
def delete_item(item_id):
    conn = get_db_connection()
    conn.execute('DELETE FROM Items WHERE item_id = ?', (item_id,))
    conn.commit()
    conn.close()
    flash('Item deleted successfully!', 'success')
    return redirect(url_for('inventory'))

if __name__ == '__main__':
    app.run(debug=True)
