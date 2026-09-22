package com.tugas.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet untuk menyelesaikan Persamaan Kuadrat (Soal 3)
 * Persamaan: ax² + bx + c = 0
 * Rumus ABC: x = (-b ± √(b²-4ac)) / 2a
 */
public class PersamaanKuadratServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Ambil input dari form
        double a = Double.parseDouble(request.getParameter("a"));
        double b = Double.parseDouble(request.getParameter("b"));
        double c = Double.parseDouble(request.getParameter("c"));

        // Validasi: a tidak boleh 0 (bukan persamaan kuadrat)
        if (a == 0) {
            request.setAttribute("error",
                "Nilai a tidak boleh 0! Jika a = 0, maka bukan persamaan kuadrat.");
            request.getRequestDispatcher("hasilkuadrat.jsp").forward(request, response);
            return;
        }

        // Hitung Diskriminan: D = b² - 4ac
        double diskriminan = (b * b) - (4 * a * c);

        String jenisAkar;
        String hasilX1;
        String hasilX2;

        if (diskriminan > 0) {
            // Dua akar real berbeda
            jenisAkar = "D > 0 → Dua akar REAL BERBEDA";
            double x1 = (-b + Math.sqrt(diskriminan)) / (2 * a);
            double x2 = (-b - Math.sqrt(diskriminan)) / (2 * a);
            hasilX1 = String.format("%.4f", x1);
            hasilX2 = String.format("%.4f", x2);

        } else if (diskriminan == 0) {
            // Dua akar real sama (kembar)
            jenisAkar = "D = 0 → Dua akar REAL SAMA (kembar)";
            double x = -b / (2 * a);
            hasilX1 = String.format("%.4f", x);
            hasilX2 = hasilX1; // Sama karena kembar

        } else {
            // Dua akar imajiner (kompleks)
            jenisAkar = "D < 0 → Dua akar IMAJINER (kompleks)";
            double realPart = -b / (2 * a);
            double imagPart = Math.sqrt(Math.abs(diskriminan)) / (2 * a);
            hasilX1 = String.format("%.4f + %.4fi", realPart, imagPart);
            hasilX2 = String.format("%.4f - %.4fi", realPart, imagPart);
        }

        // Set atribut untuk dikirim ke JSP hasil
        request.setAttribute("a", a);
        request.setAttribute("b", b);
        request.setAttribute("c", c);
        request.setAttribute("diskriminan", diskriminan);
        request.setAttribute("jenisAkar", jenisAkar);
        request.setAttribute("hasilX1", hasilX1);
        request.setAttribute("hasilX2", hasilX2);

        // Forward ke halaman hasil
        request.getRequestDispatcher("hasilkuadrat.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("persamaankuadrat.jsp");
    }
}
