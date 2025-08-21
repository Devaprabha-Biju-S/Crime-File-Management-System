from flask import Flask, render_template, request, redirect
import psycopg2

app = Flask(__name__)

# PostgreSQL connection
conn = psycopg2.connect(
    dbname="crime_db", user="postgres", password="123456789", host="localhost", port="5432"
)
cursor = conn.cursor()

# Home page – show all crimes
@app.route('/')
def index():
    cursor.execute("SELECT * FROM crimes ORDER BY date DESC;")
    crimes = cursor.fetchall()
    return render_template("index.html", crimes=crimes)

# Add FIR page – GET shows form, POST inserts FIR
@app.route('/add_fir', methods=['GET', 'POST'])
def add_fir():
    if request.method == 'POST':
        crime_id = request.form['crime_id']
        suspect_id = request.form['suspect_id']
        officer_id = request.form['officer_id']
        remarks = request.form['remarks']

        cursor.execute("""
            INSERT INTO firs (crime_id, suspect_id, officer_id, remarks)
            VALUES (%s, %s, %s, %s)
        """, (crime_id, suspect_id, officer_id, remarks))
        conn.commit()
        return redirect('/view_crimes')
    else:
        # Load dropdown values for form
        cursor.execute("SELECT crime_id, crime_type, location, date FROM crimes ORDER BY crime_id;")
        crimes = cursor.fetchall()

        cursor.execute("SELECT suspect_id, name, age FROM suspects ORDER BY suspect_id;")
        suspects = cursor.fetchall()

        cursor.execute("SELECT officer_id, name, rank FROM police_officers ORDER BY officer_id;")
        officers = cursor.fetchall()

        return render_template("add_fir.html", crimes=crimes, suspects=suspects, officers=officers)

# 🔥 NEW: View Crimes and FIRs page
@app.route('/view_crimes')
def view_crimes():
    cursor.execute("""
        SELECT c.crime_id, c.crime_type, c.location, c.date, c.status, f.fir_id, s.name, p.name
        FROM crimes c
        LEFT JOIN firs f ON c.crime_id = f.crime_id
        LEFT JOIN suspects s ON f.suspect_id = s.suspect_id
        LEFT JOIN police_officers p ON f.officer_id = p.officer_id
        ORDER BY c.date DESC
    """)
    crime_records = cursor.fetchall()
    return render_template("view_crimes.html", crime_records=crime_records)

if __name__ == '__main__':
    app.run(debug=True)
