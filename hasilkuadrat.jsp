<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hasil - Persamaan Kuadrat</title>
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
        .equation {
            text-align: center;
            font-size: 20px;
            margin-bottom: 20px;
            color: #2c3e50;
            padding: 15px;
            background: #f0f7ff;
            border-radius: 8px;
        }
        .diskriminan-info {
            text-align: center;
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-weight: bold;
        }
        .d-positif { background: #d4edda; color: #155724; }
        .d-nol { background: #fff3cd; color: #856404; }
        .d-negatif { background: #f8d7da; color: #721c24; }
        table { width: 100%; border-collapse: collapse; }
        td { padding: 12px 15px; border-bottom: 1px solid #eee; }
        td:first-child { font-weight: bold; color: #555; }
        td:last-child { text-align: right; font-size: 16px; color: #2c3e50; }
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
        .btn-retry { background: #27ae60; }
        .error-msg {
            text-align: center;
            padding: 15px;
            background: #f8d7da;
            color: #721c24;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <h1>📊 Hasil Persamaan Kuadrat</h1>
    <div class="result-container">
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error-msg"><%= error %></div>
        <%
            } else {
                double a = (Double) request.getAttribute("a");
                double b = (Double) request.getAttribute("b");
                double c = (Double) request.getAttribute("c");
                double diskriminan = (Double) request.getAttribute("diskriminan");
                String jenisAkar = (String) request.getAttribute("jenisAkar");
                String hasilX1 = (String) request.getAttribute("hasilX1");
                String hasilX2 = (String) request.getAttribute("hasilX2");

                String dClass;
                if (diskriminan > 0) dClass = "d-positif";
                else if (diskriminan == 0) dClass = "d-nol";
                else dClass = "d-negatif";
        %>

        <div class="equation">
            <b><%= a %>x² + (<%= b %>)x + (<%= c %>) = 0</b>
        </div>

        <div class="diskriminan-info <%= dClass %>">
            <%= jenisAkar %>
        </div>

        <table>
            <tr>
                <td>Nilai a</td>
                <td><%= a %></td>
            </tr>
            <tr>
                <td>Nilai b</td>
                <td><%= b %></td>
            </tr>
            <tr>
                <td>Nilai c</td>
                <td><%= c %></td>
            </tr>
            <tr>
                <td>Diskriminan (D = b²-4ac)</td>
                <td><%= diskriminan %></td>
            </tr>
            <tr>
                <td>X1</td>
                <td><%= hasilX1 %></td>
            </tr>
            <tr>
                <td>X2</td>
                <td><%= hasilX2 %></td>
            </tr>
        </table>

        <p style="margin-top:15px; color:#888; font-size:14px;">
            <b>Rumus:</b><br>
            D = b² - 4ac = (<%= b %>)² - 4(<%= a %>)(<%= c %>) = <%= diskriminan %><br>
            X = (-b ± √D) / 2a
        </p>

        <% } %>

        <div class="btn-group">
            <a href="index.jsp" class="btn-back">← Menu</a>
            <a href="persamaankuadrat.jsp" class="btn-retry">Hitung Lagi</a>
        </div>
    </div>
</body>
</html>
