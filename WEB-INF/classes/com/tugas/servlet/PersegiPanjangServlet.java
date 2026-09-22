package com.tugas.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet untuk menghitung Persegi Panjang (Soal 1 & 2)
 */
public class PersegiPanjangServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        double panjang = Double.parseDouble(request.getParameter("panjang"));
        double lebar = Double.parseDouble(request.getParameter("lebar"));

        // Soal 1: Luas dan Keliling
        double luas = panjang * lebar;
        double keliling = 2 * (panjang + lebar);

        // Soal 2: Deteksi jenis bentuk
        String jenis;
        if (panjang == lebar) {
            jenis = "BUJUR SANGKAR";
        } else {
            jenis = "PERSEGI PANJANG";
        }

        request.setAttribute("panjang", panjang);
        request.setAttribute("lebar", lebar);
        request.setAttribute("luas", luas);
        request.setAttribute("keliling", keliling);
        request.setAttribute("jenis", jenis);

        request.getRequestDispatcher("hasilpersegi.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("persegipanjang.jsp");
    }
}
