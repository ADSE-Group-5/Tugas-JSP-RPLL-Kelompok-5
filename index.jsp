<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Tugas JSP & Servlet</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 { color: #2c3e50; text-align: center; }
        .menu {
            display: flex;
            flex-direction: column;
            gap: 15px;
            margin-top: 30px;
        }
        .menu a {
            display: block;
            padding: 20px;
            background: #fff;
            border-radius: 8px;
            text-decoration: none;
            color: #2c3e50;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .menu a:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .menu a h2 { margin: 0 0 8px 0; color: #3498db; }
        .menu a p { margin: 0; color: #666; }
    </style>
</head>
<body>
    <h1>📐 Tugas JSP & Servlet</h1>

    <div class="menu">
        <a href="persegipanjang.jsp">
            <h2>Soal 1 & 2 — Persegi Panjang / Bujur Sangkar</h2>
            <p>Menghitung luas & keliling persegi panjang, dengan deteksi bujur sangkar</p>
        </a>
        <a href="persamaankuadrat.jsp">
            <h2>Soal 3 — Persamaan Kuadrat</h2>
            <p>Menyelesaikan persamaan kuadrat ax² + bx + c = 0</p>
        </a>
    </div>
</body>
</html>
