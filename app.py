from flask import Flask, render_template, request, jsonify, session, redirect
from flask_mysqldb import MySQL
from werkzeug.security import generate_password_hash,check_password_hash
from functools import wraps
from datetime import timedelta, datetime

app = Flask(__name__)

app.permanent_session_lifetime = timedelta(minutes=30)
app.secret_key ='bibuplant-secret-key'

app.config['MYSQL_HOST'] = 'switchyard.proxy.rlwy.net'
app.config['MYSQL_USER'] = 'root'       
app.config['MYSQL_PASSWORD'] = 'gdjsJHvkEAnErWlUOTpfwPesuvBVWWYk'        
app.config['MYSQL_DB'] = 'railway'
app.config['MYSQL_PORT'] = 25299

mysql = MySQL(app)

# =================MIDDLEWARE===================
def admin_required(f):
    @wraps(f)
    def wrap(*args, **kwargs):
        if session.get('role') != 'admin':
            return redirect('/login')
        return f(*args, **kwargs)
    return wrap

def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            return redirect('/login')
        return f(*args, **kwargs)
    return decorated_function
#=================ROUTE UMUM=====================

@app.route('/')
def home():
    return render_template('dashboard.html')

@app.route('/dashboard')
def dashboard(): 
    return render_template('dashboard.html')

#======================AUTH========================
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        data = request.get_json()
        username = data['username']
        password = data['password']

        cursor = mysql.connection.cursor()
        cursor.execute("""
            SELECT id, password, role 
            FROM pengguna 
            WHERE username = %s
        """, (username,))
        user = cursor.fetchone()
        cursor.close()

        print(f"Username: {username}, User fetched: {user}")

        if not user:
            return jsonify({"error": "Username tidak ditemukan"}), 401

        user_id, password_hash, role = user

        if not check_password_hash(password_hash, password):
            return jsonify({"success": False, "error": "Username atau password salah"})

        session.permanent = True
        session['user_id'] = user_id
        session['username'] = username
        session['role'] = role

        return jsonify({
            "success": True,
            "user_id": user_id,
            "role": role
        })
    
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/login')



@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if request.method == 'POST':
        data = request.get_json()

        username = data['username']
        email = data['email']

        password = generate_password_hash(data['password'])

        cursor = mysql.connection.cursor()

        cursor.execute("SELECT * FROM pengguna WHERE username = %s", (username,))
        if cursor.fetchone():
            cursor.close()
            return jsonify({"error": "Username sudah terdaftar"}), 400

        cursor.execute("""
            INSERT INTO pengguna (username, email, password, role)
            VALUES (%s, %s, %s, 'user')
        """, (username, email, password))

        mysql.connection.commit()
        cursor.close()

        return jsonify({"message": "Signup berhasil"})

    return render_template('signup.html')

#======================ADMIN=============================
@app.route('/admin-dashboard')
@admin_required
def admin_dashboard():
    return render_template('admin_dashboard.html')

@app.route('/riwayatpengguna')
@admin_required
def riwayatpengguna():
    return render_template('admin_riwayatpengguna.html')

@app.route('/api/riwayat-pengguna')
@admin_required
def api_riwayat_pengguna():
    cursor = mysql.connection.cursor()
    cursor.execute("""
        SELECT 
            user_id,
            username,
            tanggal,
            gejala,
            kode_penyakit,
            similarity
        FROM riwayat_pengguna
        ORDER BY tanggal DESC
    """)
    rows = cursor.fetchall()
    cursor.close()

    data = []
    for r in rows:
        data.append({
            "user_id": r[0],
            "username": r[1],
            "tanggal": r[2].strftime('%Y-%m-%d %H:%M'),
            "gejala": r[3],
            "kode_penyakit": r[4],
            "similarity": r[5]
        })
    return jsonify(data)

@app.route('/basispengetahuan')
@admin_required
def basispengetahuan():
    return render_template('admin_basispengetahuan.html')

@app.route("/tambah_basis")
def tambah_basis():
    return render_template("tambah_basis.html")

@app.route("/edit_basis/<string:kode>")
def edit_basis(kode):
    return render_template("edit_basis.html")

@app.route('/datapenyakit')
@admin_required
def datapenyakit(): 
    return render_template('admin_datapenyakit.html')

@app.route("/tambah_penyakit")
def tambah_penyakit():
    return render_template("tambah_penyakit.html")

@app.route("/edit_penyakit/<string:kode>")
def edit_penyakit(kode):
    return render_template("edit_penyakit.html")

@app.route('/datagejala')
@admin_required
def datagejala():   
    return render_template('admin_datagejala.html')

@app.route("/tambah_gejala")
def tambah_gejala():
    return render_template("tambah_gejala.html")

@app.route("/edit_gejala/<kode>")
def edit_gejala(kode):
    return render_template("edit_gejala.html")

@app.route('/datapengobatan')
@admin_required
def datapengobatan():
    return render_template('admin_datapengobatan.html')

@app.route("/tambah_pengobatan")
def tambah_pengobatan():
    return render_template("tambah_pengobatan.html")

@app.route("/edit_pengobatan/<string:kode>")
def edit_pengobatan(kode):
    return render_template("edit_pengobatan.html")

@app.route('/datapencegahan')
@admin_required
def datapencegahan():
    return render_template('admin_datapencegahan.html')

@app.route("/tambah_pencegahan")
def tambah_pencegahan():
    return render_template("tambah_pencegahan.html")

@app.route("/edit_pencegahan/<string:kode>")
def edit_pencegahan(kode):
    return render_template("edit_pencegahan.html")

@app.route('/add_disease', methods=['POST'])
def add_disease(): 
    try:
        data = request.get_json()
        disease_kode = data['kode']
        disease_name = data['name']
        disease_desc = data['deskripsi']
        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO penyakit (Kode, Jenis_Penyakit, Deskripsi) VALUES (%s, %s, %s)", (disease_kode, disease_name, disease_desc))
        mysql.connection.commit()
        cursor.close()
        return jsonify({'message': 'Disease added successfully.'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500
    
@app.route('/get_disease')
def get_disease():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Kode, Jenis_Penyakit, Deskripsi FROM penyakit ORDER BY Kode ASC")
    data = cursor.fetchall()
    cursor.close()

    result = []
    for row in data:
        result.append({
            "kode": row[0],
            "name": row[1],
            "deskripsi": row[2]
        })

    return jsonify(result)

@app.route('/delete_disease/<string:kode>', methods=['DELETE'])
def delete_disease(kode):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM penyakit WHERE Kode = %s", (kode))
    if cursor.fetchone() is None:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    cursor.execute("DELETE FROM penyakit WHERE Kode = %s", (kode))
    mysql.connection.commit()
    cursor.close()
    return jsonify({"message": "Deleted"})

@app.route('/update_disease/<int:id>', methods=['PUT'])     
def update_disease(id):
    data = request.get_json()
    cursor = mysql.connection.cursor()

    cursor.execute("""
        UPDATE penyakit
        SET Kode=%s, Jenis_Penyakit=%s, Deskripsi=%s
        WHERE No=%s
    """, (data['kode'], data['name'], data['deskripsi'], id))

    mysql.connection.commit()
    cursor.close()

    return jsonify({"message": "Data berhasil diupdate"})

@app.route("/get_disease_by_id/<kode>")
def get_disease_by_id(kode):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Kode, Jenis_Penyakit, Deskripsi FROM penyakit WHERE Kode = %s", (kode,))
    row = cursor.fetchone()
    cursor.close()

    if not row:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    return jsonify({
        "kode": row[0],
        "name": row[1]
    })

@app.route('/add_symptom', methods=['POST'])
def add_symptom(): 
    try:
        data = request.get_json()
        symptom_kode = data['kode']
        symptom_name = data['name']
        symptom_bobot = data['bobot']
        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO gejala (Kode, Gejala, Bobot) VALUES (%s, %s, %s)", (symptom_kode, symptom_name, symptom_bobot))
        mysql.connection.commit()
        cursor.close()
        return jsonify({'message': 'Symptom added successfully.'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/get_symptom')
def get_symptom():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Kode, Gejala, Bobot FROM gejala ORDER BY Kode ASC")
    data = cursor.fetchall()
    cursor.close()

    result = []
    for row in data:
        result.append({
            "kode": row[0],
            "name": row[1],
            "bobot": row[2]
        })

    return jsonify(result)

@app.route('/delete_symptom/<string:kode>', methods=['DELETE'])
def delete_symptom(kode):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM gejala WHERE Kode = %s", (kode,))
    if cursor.fetchone() is None:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    cursor.execute("DELETE FROM gejala WHERE Kode = %s", (kode,))
    mysql.connection.commit()
    cursor.close()
    return jsonify({"message": "Deleted"})

@app.route('/update_symptom/<string:kode>', methods=['PUT'])
def update_symptom(kode):
    data = request.get_json()
    cursor = mysql.connection.cursor()

    cursor.execute("""
        UPDATE gejala
        SET Gejala=%s, Bobot=%s
        WHERE Kode=%s
    """, (data['name'], data['bobot'], kode))

    mysql.connection.commit()
    cursor.close()

    return jsonify({"message": "Data berhasil diupdate"})

@app.route("/get_symptom_by_id/<kode>")
def get_symptom_by_id(kode):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Kode, Gejala, Bobot FROM gejala WHERE Kode = %s", (kode,))
    row = cursor.fetchone()
    cursor.close()

    if not row:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    return jsonify({
        "kode": row[0],
        "name": row[1],
        "bobot": row[2]
    })

@app.route('/add_treatment', methods=['POST'])
def add_treatment(): 
    
    try:
        data = request.get_json()
        treatment_kode = data['kode']
        treatment_name = data['name']
        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO pengobatan (Kode, Pengobatan) VALUES (%s, %s)", (treatment_kode, treatment_name,))
        mysql.connection.commit()
        cursor.close()
        return jsonify({'message': 'Treatment added successfully.'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/get_treatment')
def get_treatment():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Kode, Pengobatan FROM pengobatan ORDER BY Kode ASC")
    data = cursor.fetchall()
    cursor.close()

    result = []
    for row in data:
        result.append({
            "kode": row[0],
            "name": row[1]
        })

    return jsonify(result)

@app.route('/delete_treatment/<string:kode>', methods=['DELETE'])
def delete_treatment(kode):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM pengobatan WHERE Kode = %s", (kode))
    if cursor.fetchone() is None:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    cursor.execute("DELETE FROM pengobatan WHERE Kode = %s", (kode))
    mysql.connection.commit()
    cursor.close()
    return jsonify({"message": "Deleted"})

@app.route('/update_treatment/<string:kode>', methods=['PUT'])
def update_treatment(kode):
    data = request.get_json()
    cursor = mysql.connection.cursor()

    cursor.execute("""
        UPDATE pengobatan
        SET Pengobatan=%s
        WHERE Kode=%s
    """, (data['name'], kode))

    mysql.connection.commit()
    cursor.close()

    return jsonify({"message": "Data berhasil diupdate"})

@app.route("/get_treatment_by_id/<kode>")
def get_treatment_by_id(kode):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Kode, Pengobatan FROM pengobatan WHERE Kode = %s", (kode,))
    row = cursor.fetchone()
    cursor.close()

    if not row:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    return jsonify({
        "kode": row[0],
        "name": row[1]
    })

@app.route('/add_prevention', methods=['POST'])
def add_prevention(): 
    try:
        data = request.get_json()
        prevention_kode = data['kode']
        prevention_name = data['name']
        cursor = mysql.connection.cursor()
        cursor.execute("INSERT INTO pencegahan (Kode, Pencegahan) VALUES (%s, %s)", (prevention_kode, prevention_name,))
        mysql.connection.commit()
        cursor.close()
        return jsonify({'message': 'Prevention added successfully.'}), 201
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/get_prevention')
def get_prevention():
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Kode, Pencegahan FROM pencegahan ORDER BY Kode ASC")
    data = cursor.fetchall()
    cursor.close()

    result = []
    for row in data:
        result.append({
            "kode": row[0],
            "name": row[1]
        })

    return jsonify(result)

@app.route('/delete_prevention/<string:kode>', methods=['DELETE'])
def delete_prevention(kode):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT * FROM pencegahan WHERE Kode = %s", (kode))
    if cursor.fetchone() is None:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    cursor.execute("DELETE FROM pencegahan WHERE Kode = %s", (kode))
    mysql.connection.commit()
    cursor.close()
    return jsonify({"message": "Deleted"})

@app.route('/update_prevention/<string:kode>', methods=['PUT'])
def update_prevention(kode):
    data = request.get_json()
    cursor = mysql.connection.cursor()

    cursor.execute("""
        UPDATE pencegahan
        SET Pencegahan=%s
        WHERE Kode=%s
    """, (data['name'], kode))

    mysql.connection.commit()
    cursor.close()

    return jsonify({"message": "Data berhasil diupdate"})

@app.route("/get_prevention_by_id/<kode>")
def get_prevention_by_id(kode):
    cursor = mysql.connection.cursor()
    cursor.execute("SELECT Kode, Pencegahan FROM pencegahan WHERE Kode = %s", (kode,))
    row = cursor.fetchone()
    cursor.close()

    if not row:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    return jsonify({
        "kode": row[0],
        "name": row[1]
    })

@app.route('/add_basis', methods=['POST'])
def add_basis():
    data = request.get_json()
    cursor = mysql.connection.cursor()
    cursor.execute("""
        INSERT INTO basis_pengetahuan (Kode_Penyakit, Kode_Gejala)
        VALUES (%s, %s)
    """, (data['penyakit'], data['gejala']))
    mysql.connection.commit()
    cursor.close()
    return jsonify({"message": "Basis pengetahuan berhasil ditambahkan"})

@app.route('/get_basis')
def get_basis():
    cursor = mysql.connection.cursor()
    cursor.execute("""
        SELECT 
            bp.No,
            p.Kode AS kode_penyakit,
            p.Jenis_Penyakit,
            g.Kode AS kode_gejala,
            g.Gejala,
            g.Bobot AS bobot_gejala
        FROM basis_pengetahuan bp
        JOIN penyakit p ON bp.Kode_Penyakit = p.Kode
        JOIN gejala g ON bp.Kode_Gejala = g.Kode
        ORDER BY bp.No ASC
    """)
    data = cursor.fetchall()
    cursor.close()

    return jsonify([
        {
            "id": row[0],
            "kode_penyakit": row[1],
            "nama_penyakit": row[2],
            "kode_gejala": row[3],
            "jenis_gejala": row[4],
            "bobot_gejala":row[5]
        }
        for row in data
    ])


@app.route('/delete_basis/<int:id>', methods=['DELETE'])
def delete_basis(id):
    cursor = mysql.connection.cursor()
    cursor.execute("DELETE FROM basis_pengetahuan WHERE No = %s", (id,))
    mysql.connection.commit()
    cursor.close()
    return jsonify({"message": "Deleted"})

@app.route('/update_basis/<int:id>', methods=['PUT'])
def update_basis(id):
    data = request.get_json()
    cursor = mysql.connection.cursor()
    cursor.execute("""
        UPDATE basis_pengetahuan
        SET Kode_Penyakit=%s, Kode_Gejala=%s
        WHERE No=%s
    """,(data['penyakit'],data['gejala'],id))
    mysql.connection.commit()
    cursor.close()
    return jsonify({"message":"Data berhasil diupdate"})

@app.route("/get_basis_by_id/<int:id>")
def get_basis_by_id(id):
    cursor = mysql.connection.cursor()

    cursor.execute("""
        SELECT Kode_Penyakit, Kode_Gejala
        FROM basis_pengetahuan
        WHERE No = %s
    """, (id,))

    row = cursor.fetchone()
    cursor.close()

    if not row:
        return jsonify({"error": "Data tidak ditemukan"}), 404

    return jsonify({
        "kode_penyakit": row[0],
        "kode_gejala": row[1]
    })

@app.route('/admin/riwayat')
@admin_required
def admin_riwayat():
    return render_template('admin_riwayat.html')

@app.route('/admin/get-riwayat')
@admin_required
def admin_get_riwayat():
    cursor = mysql.connection.cursor()
    cursor.execute("""
        SELECT 
            user_id,
            username,
            tanggal,
            gejala,
            kode_penyakit,
            similarity
        FROM riwayat_pengguna
        ORDER BY tanggal DESC
    """)
    rows = cursor.fetchall()
    cursor.close()

    return jsonify([
        {
            "user_id": r[0],
            "username": r[1],
            "tanggal": r[2].strftime('%Y-%m-%d %H:%M'),
            "gejala": r[3],
            "kode_penyakit": r[4],
            "similarity": r[5]
        } for r in rows
    ])

#=======================USER===========================

@app.route('/diagnosa')
@login_required
def diagnosa():
    return render_template('diagnosa.html')

@app.route('/hasil-diagnosa')
def hasil_diagnosa():
    return render_template('diagnosa2.html')

@app.route('/diagnosa2', methods=['GET', 'POST'])
@login_required
def diagnosa2():
    if request.method == 'GET':
        return render_template('diagnosa2.html')

    data = request.get_json(force=True)
    gejala_user = set(data['gejala'])

    cursor = mysql.connection.cursor()

    cursor.execute("""
    SELECT 
        p.Kode,
        p.Jenis_Penyakit,
        p.Deskripsi,

        GROUP_CONCAT(DISTINCT ob.Pengobatan SEPARATOR '<br>') AS Pengobatan,
        GROUP_CONCAT(DISTINCT pc.Pencegahan SEPARATOR '<br>') AS Pencegahan

        FROM penyakit p

        LEFT JOIN penyakit_pengobatan pp 
            ON pp.kode_penyakit = p.Kode
        LEFT JOIN pengobatan ob 
            ON ob.Kode = pp.kode_pengobatan

        LEFT JOIN penyakit_pencegahan pp2 
            ON pp2.kode_penyakit = p.Kode
        LEFT JOIN pencegahan pc 
            ON pc.Kode = pp2.kode_pencegahan

        GROUP BY p.Kode, p.Jenis_Penyakit, p.Deskripsi
        """)

    penyakit_list = cursor.fetchall()
    hasil = []

## Rumus Similarity
    for p in penyakit_list:
        cursor.execute("""
            SELECT Kode_Gejala, bobot
            FROM basis_pengetahuan
            WHERE Kode_Penyakit = %s
        """, (p[0],))

        rows = cursor.fetchall()
        if not rows:
            continue

        total_similarity = 0
        total_bobot = 0

        for kode_gejala, bobot in rows:
            bobot = float(bobot)
            total_bobot += bobot

            match = 1 if kode_gejala in gejala_user else 0
            total_similarity += match * bobot

        similarity = total_similarity / total_bobot if total_bobot else 0


        hasil.append({
            "kode": p[0],
            "nama": p[1],
            "deskripsi": p[2],
            "pengobatan": p[3] or "-",
            "pencegahan": p[4] or "-",
            "persentase": round(similarity * 100, 2)
        })

## Simpan riwayat diagnosa
    if hasil:
        hasil.sort(key=lambda x: x['persentase'], reverse=True)
        top = hasil[0]

        gejala_str = ",".join(sorted(gejala_user))

        cursor.execute("""
            INSERT INTO riwayat_pengguna
            (user_id, username, tanggal, gejala, kode_penyakit, similarity)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            session['user_id'],
            session['username'],
            datetime.now(),
            gejala_str,
            top['kode'],
            top['persentase']
        ))

        mysql.connection.commit()

    cursor.close()
    return jsonify(hasil)

@app.route('/riwayat')
@login_required
def riwayat():
    return render_template('riwayat.html')

@app.route('/user/get-riwayat')
@login_required
def user_get_riwayat():
    cursor = mysql.connection.cursor()
    cursor.execute("""
        SELECT 
            user_id,
            username,
            tanggal,
            gejala,
            kode_penyakit,
            similarity
        FROM riwayat_pengguna
        WHERE user_id = %s
        ORDER BY tanggal DESC
    """, (session['user_id'],))
    rows = cursor.fetchall()
    cursor.close()

    return jsonify([
        {
            "user_id": r[0],
            "username": r[1],
            "tanggal": r[2].strftime('%Y-%m-%d %H:%M'),
            "gejala": r[3],
            "kode_penyakit": r[4],
            "similarity": r[5]
        } for r in rows
    ])

if __name__ == "__main__":
    app.run(debug=True)
