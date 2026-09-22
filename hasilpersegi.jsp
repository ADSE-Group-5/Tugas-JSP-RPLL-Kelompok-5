<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hasil - Persegi Panjang</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            max-width: 600px;
            margin: 40px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        h1 { color: #2c3e50; text-align: center; }
        .result-container {
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .jenis {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .bujursangkar { background: #d4edda; color: #155724; }
        .persegipanjang { background: #cce5ff; color: #004085; }
        table { width: 100%; border-collapse: collapse; }
        td { padding: 12px 15px; border-bottom: 1px solid #eee; }
        td:first-child { font-weight: bold; color: #555; }
        td:last-child { text-align: right; font-size: 18px; color: #2c3e50; }
        .btn-group { display: flex; gap: 10px; margin-top: 20px; }
        .btn-group a {
            flex: 1;
            text-align: center;
            padding: 12px;
            border-radius: 4px;
            text-decoration: none;
            color: white;
        }
        .btn-back { background: #6c757d; }
        .btn-retry { background: #3498db; }
    </style>
</head>
<body>
    <h1>📐 Hasil Perhitungan</h1>
    <div class="result-container">
        <%
            String jenis = (String) request.getAttribute("jenis");
            double panjang = (Double) request.getAttribute("panjang");
            double lebar = (Double) request.getAttribute("lebar");
            double luas = (Double) request.getAttribute("luas");
            double keliling = (Double) request.getAttribute("keliling");

            String jenisClass = jenis.equals("BUJUR SANGKAR") ? "bujursangkar" : "persegipanjang";
        %>

        <!-- Soal 2: Menampilkan jenis bentuk -->
        <div class="jenis <%= jenisClass %>">
            Bentuk: <%= jenis %>
        </div>

        <table>
            <tr>
                <td>Panjang</td>
                <td><%= panjang %></td>
            </tr>
            <tr>
                <td>Lebar</td>
                <td><%= lebar %></td>
            </tr>
            <tr>
                <td>Luas</td>
                <td><%= luas %></td>
            </tr>
            <tr>
                <td>Keliling</td>
                <td><%= keliling %></td>
            </tr>
        </table>

        <p style="margin-top:15px; color:#888; font-size:14px;">
            <b>Rumus:</b><br>
            Luas = Panjang × Lebar = <%= panjang %> × <%= lebar %> = <%= luas %><br>
            Keliling = 2 × (Panjang + Lebar) = 2 × (<%= panjang %> + <%= lebar %>) = <%= keliling %>
        </p>

        <div class="btn-group">
            <a href="index.jsp" class="btn-back">← Menu</a>
            <a href="persegipanjang.jsp" class="btn-retry">Hitung Lagi</a>
        </div>
    </div>
</body>
</html>
