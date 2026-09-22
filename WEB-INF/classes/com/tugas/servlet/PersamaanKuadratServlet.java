package com.tugas.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet untuk menyelesaikan Persamaan Kuadrat (Soal 3)
 * ax^2 + bx + c = 0
 */
public class PersamaanKuadratServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        double a = Double.parseDouble(request.getParameter("a"));
        double b = Double.parseDouble(request.getParameter("b"));
        double c = Double.parseDouble(request.getParameter("c"));

        if (a == 0) {
            request.setAttribute("error",
                "Nilai a tidak boleh 0! Jika a = 0, maka bukan persamaan kuadrat.");
            request.getRequestDispatcher("hasilkuadrat.jsp").forward(request, response);
            return;
        }

        double diskriminan = (b * b) - (4 * a * c);

        String jenisAkar;
        String hasilX1;
        String hasilX2;

        if (diskriminan > 0) {
            jenisAkar = "D > 0 → Dua akar REAL BERBEDA";
            double x1 = (-b + Math.sqrt(diskriminan)) / (2 * a);
            double x2 = (-b - Math.sqrt(diskriminan)) / (2 * a);
            hasilX1 = String.format("%.4f", x1);
            hasilX2 = String.format("%.4f", x2);

        } else if (diskriminan == 0) {
            jenisAkar = "D = 0 → Dua akar REAL SAMA (kembar)";
            double x = -b / (2 * a);
            hasilX1 = String.format("%.4f", x);
            hasilX2 = hasilX1;

        } else {
            jenisAkar = "D < 0 → Dua akar IMAJINER (kompleks)";
            double realPart = -b / (2 * a);
            double imagPart = Math.sqrt(Math.abs(diskriminan)) / (2 * a);
            hasilX1 = String.format("%.4f + %.4fi", realPart, imagPart);
            hasilX2 = String.format("%.4f - %.4fi", realPart, imagPart);
        }

        request.setAttribute("a", a);
        request.setAttribute("b", b);
        request.setAttribute("c", c);
        request.setAttribute("diskriminan", diskriminan);
        request.setAttribute("jenisAkar", jenisAkar);
        request.setAttribute("hasilX1", hasilX1);
        request.setAttribute("hasilX2", hasilX2);

        request.getRequestDispatcher("hasilkuadrat.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("persamaankuadrat.jsp");
    }
}
