from flask import Flask, render_template, request, redirect
import psycopg2

app = Flask(__name__)

conn = psycopg2.connect(
    dbname="crime_db", user="postgres", password="your_password", host="localhost", port="5432"
)
cursor = conn.cursor()

@app.route('/')
def index():
    cursor.execute("SELECT * FROM crimes ORDER BY date DESC;")
    crimes = cursor.fetchall()
    return render_template("index.html", crimes=crimes)

@app.route('/add_fir', methods=['GET', 'POST'])
def add_fir():
    if request.method == 'POST':
        crime_id = request.form['crime_id']
        suspect_id = request.form['suspect_id']
        officer_id = request.form['officer_id']
        remarks = request.form['remarks']
        cursor.execute(
            "INSERT INTO firs (crime_id, suspect_id, officer_id, remarks) VALUES (%s, %s, %s, %s);",
            (crime_id, suspect_id, officer_id, remarks)
        )
        conn.commit()
        return redirect('/')
    cursor.execute("SELECT crime_id FROM crimes")
    crimes = cursor.fetchall()
    return render_template("add_fir.html", crimes=crimes)

if __name__ == '__main__':
    app.run(debug=True)
