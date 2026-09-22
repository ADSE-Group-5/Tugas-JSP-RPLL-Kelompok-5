<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Soal 3 - Persamaan Kuadrat</title>
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
        .equation {
            text-align: center;
            font-size: 22px;
            margin-bottom: 20px;
            color: #2c3e50;
            padding: 15px;
            background: #f0f7ff;
            border-radius: 8px;
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
            background: #27ae60;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
        }
        button:hover { background: #219a52; }
        a { display: block; text-align: center; margin-top: 20px; color: #3498db; }
    </style>
</head>
<body>
    <h1>📊 Persamaan Kuadrat</h1>
    <div class="form-container">
        <div class="equation">
            <b>ax² + bx + c = 0</b>
        </div>
        <form action="HitungPersamaanKuadrat" method="post">
            <label for="a">Nilai a:</label>
            <input type="number" id="a" name="a" step="any" required placeholder="Masukkan nilai a (a ≠ 0)">

            <label for="b">Nilai b:</label>
            <input type="number" id="b" name="b" step="any" required placeholder="Masukkan nilai b">

            <label for="c">Nilai c:</label>
            <input type="number" id="c" name="c" step="any" required placeholder="Masukkan nilai c">

            <button type="submit">Selesaikan</button>
        </form>
    </div>
    <a href="index.jsp">← Kembali ke Menu</a>
</body>
</html>
