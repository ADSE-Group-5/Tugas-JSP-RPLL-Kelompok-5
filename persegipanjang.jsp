<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Soal 1 & 2 - Persegi Panjang</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 { color: #2c3e50; text-align: center; }
        .form-container {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        label { display: block; margin-bottom: 5px; font-weight: bold; color: #333; }
        input[type="number"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        button {
            width: 100%;
            padding: 12px;
            background: #3498db;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover { background: #2980b9; }
        a { display: block; text-align: center; margin-top: 20px; color: #3498db; }
    </style>
</head>
<body>
    <h1>📐 Persegi Panjang / Bujur Sangkar</h1>
    <div class="form-container">
        <form action="HitungPersegiPanjang" method="post">
            <label for="panjang">Panjang:</label>
            <input type="number" id="panjang" name="panjang" step="any" required placeholder="Masukkan panjang">

            <label for="lebar">Lebar:</label>
            <input type="number" id="lebar" name="lebar" step="any" required placeholder="Masukkan lebar">

            <button type="submit">Hitung</button>
        </form>
    </div>
    <a href="index.jsp">← Kembali ke Menu</a>
</body>
</html>
